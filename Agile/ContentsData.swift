//
//  ContentsData.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 28..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import Foundation

class ContentsData: NSObject {
    var createdAt:String!
    var id:Int!
    var status:String!
    var teamId:Int!
    var userContent:String!
    var userId:Int!
    var updatedAt:String!
    
    init(ContentsData:NSDictionary) {
        self.createdAt = ContentsData["created_at"] as! String
        self.id = ContentsData["id"] as! Int
        self.status = ContentsData["status"] as! String
        self.teamId = ContentsData["team_id"] as! Int
        self.userContent = ContentsData["user_content"] as! String
        self.updatedAt = ContentsData["updated_at"] as! String
        self.userId = ContentsData["user_id"] as! Int
    }
}
