//
//  ContentsData.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 28..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import Foundation

class TaskData: NSObject {
    var createdAt:String!
    var id:Int!
    var status:String!
    var projectId:Int!
    var userTask:String!
    var userId:Int!
    var updatedAt:String!
    var uId:String!
    var userName:String!
    
    init(TaskData:NSDictionary) {
        self.createdAt = TaskData["created_at"] as! String
        self.id = TaskData["id"] as! Int
        self.status = TaskData["status"] as! String
        self.projectId = TaskData["team_id"] as! Int
        self.userTask = TaskData["user_content"] as! String
        self.updatedAt = TaskData["updated_at"] as! String
        self.userId = TaskData["user_id"] as! Int
        self.uId = TaskData["uid"] as! String!
        self.userName = TaskData["username"] as! String!
    }
}
