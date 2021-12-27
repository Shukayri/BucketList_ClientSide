//
//  ListModel.swift
//  Bucket_List_ClientSide
//
//  Created by Abdulmajeed Shukayri on 27/12/2021.
//

import Foundation

class ListModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func addingToList(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    
    static func updateSelectedTask(id:Int,task: NSDictionary, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
            var request = URLRequest(url: urlToReq)
            // Set the method to PUT for update
            request.httpMethod = "PUT"
            do{
                let bodyData = try JSONSerialization.data(withJSONObject: task, options: .prettyPrinted)
                request.httpBody = bodyData
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: completionHandler)
                task.resume()
            }catch{
                print(error)
            }
    }
}
    
    static func deleteSelectedTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)") {
            var request = URLRequest(url: urlToReq)
            // Set the method to DELETE for delete
            request.httpMethod = "DELETE"
            let bodyData = "id\(id)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        }
    }
    
}
