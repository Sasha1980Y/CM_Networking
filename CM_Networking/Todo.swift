//
//  Todo.swift
//  CM_Networking
//
//  Created by AlexanderYakovenko on 7/15/17.
//  Copyright © 2017 AlexanderYakovenko. All rights reserved.
//

import Foundation

class Todo {
    var title: String
    var id: Int?
    var userId: Int
    var isCompleted: Bool
    
    required init? (title: String, id: Int?, userId: Int, completedStatus: Bool) {
        self.title = title
        self.id = id
        self.userId = userId
        self.isCompleted = completedStatus
        
        }
    func description() -> String {
            return "ID: \(self.id), " +
            "User ID: \(self.userId)" +
            "Title: \(self.title)\n" +
            "Completed: \(self.isCompleted)\n"
        }

    
}
