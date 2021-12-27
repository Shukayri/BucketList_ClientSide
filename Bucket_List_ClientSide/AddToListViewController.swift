//
//  AddToListViewController.swift
//  Bucket_List_ClientSide
//
//  Created by Abdulmajeed Shukayri on 27/12/2021.
//

import UIKit

class AddToListViewController: UIViewController {

    var delegate : ViewController?

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
        let text = textField.text!
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
    


