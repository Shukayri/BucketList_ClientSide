//
//  ViewController.swift
//  Bucket_List_ClientSide
//
//  Created by Abdulmajeed Shukayri on 27/12/2021.
//

import UIKit

class ViewController: UITableViewController {

    var tasks = [NSDictionary]()
    var index: IndexPath?
    var id: Int?
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            myListModel()
        }
   
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]["objective"] as? String
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let re = segue.destination as! AddToListViewController
        re.delegate = self
        
        if let taskEdit = sender as? NSDictionary{
            re.index = index
            re.id = id
            re.taskEdit = taskEdit
        }}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.id = tasks[indexPath.row].value(forKey: "id") as! Int
        self.index = indexPath
        performSegue(withIdentifier: "", sender: tasks[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = tasks[indexPath.row].value(forKey: "id") as! Int
        ListModel.deleteSelectedTask(id: id, completionHandler: {
            data, response , error in
            if data != nil{
                DispatchQueue.main.async {
                    self.tasks.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
               
                }
            else{
                print("Nothing Happened")
            }
        })
    }
    
        
        
    func myListModel(){
        ListModel.getAllTasks() {
            data, response, error in
            do {
                if data != nil {
                let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                    for task in tasks! {
                        self.tasks.append(task as! NSDictionary)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }}
    

}





