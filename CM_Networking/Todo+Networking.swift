//
//  Todo+Networking.swift
//  CM_Networking
//
//  Created by AlexanderYakovenko on 7/15/17.
//  Copyright © 2017 AlexanderYakovenko. All rights reserved.
//

import Foundation
import Alamofire

extension Todo {
    
    enum BackendError: Error {
        case objectSerialisation(reason: String)
    }
    
    
    convenience init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
        let userId = json["userId"] as? Int,
        let isCompleted = json["completed"] as? Bool
            else {
                
                return nil
        }
        let idValue = json["id"] as? Int
        self.init(title: title, id: idValue, userId: userId, completedStatus: isCompleted)
    }
    
    
    class func todoByID(id: Int, completionHandler: @escaping(Result<Todo>) -> Void) {
        Alamofire.request(TodoRouter.get(id))
            .responseJSON { response in
               let result = Todo.todoFromResponse(response: response)
                completionHandler(result)
                
        }
    }
    
    func save(completionHandler: @escaping(Result<Todo> ) -> Void){
        let fields = self.toJSON()
        Alamofire.request(TodoRouter.create(fields)).responseJSON { response in
            
            let result = Todo.todoFromResponse(response: response)
            completionHandler(result)
            
        }
    }
    
    
    func toJSON() -> [String: Any] {
        var json = [String: Any]()
         json["title"] = title
        if let id = id {
            json["id"] = id
        }
        json["userId"] = userId
            
        json["completed"] = isCompleted
            
        
        return json
    }
    
    private class func todoFromResponse(response: DataResponse<Any>) -> Result<Todo> {
        
        
        // check for errors from responseJSON
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            
            print(response.result.error!)
            let failure = Result<Todo>.failure(response.result.error!)
            return failure
        }
        // make sure we got a JSON dictionary
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get todo object as JSON from API")
            
            return .failure(BackendError.objectSerialisation(reason: "Did not get JSON dictionary in response"))
        }
        
        // turn JSON in to Todo object
        
        guard let todo = Todo(json: json) else {
            
            
            return .failure(BackendError.objectSerialisation(reason: "Could not create Todo object from JSON"))
        }
        return .success(todo)

        
    }
    
    
}
