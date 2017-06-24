//
//  ViewController.swift
//  CM_Networking
//
//  Created by AlexanderYakovenko on 6/24/17.
//  Copyright © 2017 AlexanderYakovenko. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test code goes here like this
        let todoEndPoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        //let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        
        Alamofire.request(todoEndPoint, method: .delete).responseJSON(completionHandler: { response in
        
            if !response.result.isSuccess {
                print("Call failed")
                return
            }
            print("delete ok")
        })
        
        
        
        
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postJSON() {
        
        
        // test code goes here like this
        let todoEndPoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        Alamofire.request(todoEndPoint, method: .post, parameters: newTodo, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            if response.result.isSuccess {
                print("OK")
                //return
            }
            
            guard let json = response.result.value as? [String:Any] else {
                print("error in responseJSON")
                return
            }
            guard let title = json["title"] else {
                print("value with key title not exist")
                return
            }
            print(title)
            
            
            
        })
        

        
    }
    
    
    
    
    
    func getAlamoFire() {
        
        let todoEndPoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        
        Alamofire.request(todoEndPoint).responseJSON(completionHandler:
            { response in
                if response.result.isSuccess {
                    print("OK")
                    return
                }
                
                guard let json = response.result.value as? [String:Any] else {
                    print("error in responseJSON")
                    return
                }
                guard let title = json["title"] else {
                    print("value with key title not exist")
                    return
                }
                print(title)
                
                
        }).responseString(completionHandler: {
            response in
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                print(value)
            }
        })

        
    }
    
    
    
    
    // MARK: Handle URLSession
    func sesionURL() {
        // test code goes here like this
        let todoEndPoint: String = "https://jsonplaceholder.typicode.com/todos"
        
        guard let url = URL(string: todoEndPoint) else {
            print("error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        
        let newTodo: [String: Any] = ["title": "My First todo", "completed": false, "userID": 1]
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            urlRequest.httpBody = jsonTodo
        } catch {
            print("Error")
            return
        }
        
        // ... keep adding test code here
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            // Error handling
            if let error = error {
                print("error occurred. Error = \(error)")
                return
            }
            
            // Check if data exist
            guard let dataResponse = data else {
                print("didnot receive data")
                return
            }
            do {
                guard let todo = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                print("todo = \(todo) ")
                
                guard let todoTitle = todo["title"] as? String else {
                    print("not JSON")
                    return
                }
                print("Title \(todoTitle)")
                
                
                
            } catch {
                print("error is nil")
            }
            
            
            
            
        }
        task.resume()
        
        /*
         let myCompletionHandler: (Data?, URLResponse?, Error?) -> Void = {
         (data, response, error) in
         
         if let response = response {
         print(response)
         }
         if let error = error {
         print(error)
         }
         }
         let task = session.dataTask(with: urlRequest, completionHandler: myCompletionHandler)
         task.resume()
         */
        }


}

