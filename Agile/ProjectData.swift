//
//  teamData.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 28..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import Foundation

class ProjectData: NSObject {
    var createdAt:String!
    var id:Int!
    var projectTitle:String!
    var makerId:Int!
    var projectPassword:String!
    var updatedAt:String!
    
    init(ProjectData:NSDictionary) {
        self.createdAt = ProjectData["created_at"] as! String
        self.id = ProjectData["id"] as! Int
        self.projectTitle = ProjectData["team_title"] as! String
        self.makerId = ProjectData["teamjang"] as! Int
        self.projectPassword = ProjectData["teampassword"] as! String
        self.updatedAt = ProjectData["updated_at"] as! String
    }
}
