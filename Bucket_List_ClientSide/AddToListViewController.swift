//
//  AddToListViewController.swift
//  Bucket_List_ClientSide
//
//  Created by Abdulmajeed Shukayri on 27/12/2021.
//

import UIKit

class AddToListViewController: UIViewController {

    var delegate: ViewController?
    var taskEdit: NSDictionary?
    var index: IndexPath?
    var id: Int?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
        let text = textField.text!
        if taskEdit != nil{
            taskEdit?.setValue(text, forKey: "objective")
        
        ListModel.updateSelectedTask(id:id! ,task: taskEdit!, completionHandler: {
            data, response , error in
            if data != nil{
                do{
                let task = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                DispatchQueue.main.async {
                    print("tasks: \(task)")
                    self.delegate?.tasks[(self.index?.row)!] = self.taskEdit!
                    self.delegate?.tableView.reloadData()
                    let _ = self.navigationController?.viewControllers.popLast()
                }
                }catch{
                    print(error)
                }
            }
        })
        }else {
            ListModel.addingToList(objective: text, completionHandler: {
                data, response , error in
                if data != nil{
                    do{
                    let task = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    DispatchQueue.main.async {
                        self.delegate?.tasks.append(task)
                        self.delegate?.tableView.reloadData()
                        let _ = self.navigationController?.viewControllers.popLast()
                    }
                    }catch{
                        print(error)
                    }
                }else{
                    print("Something went wrong")
                }
            })
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = taskEdit?.value(forKey: "objective") as? String

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
    


