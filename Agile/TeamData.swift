//
//  teamData.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 28..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import Foundation

class TeamData: NSObject {
    var createdAt:String!
    var id:Int!
    var teamTitle:String!
    var makerId:Int!
    var teamPassword:String!
    var updatedAt:String!
    
    init(TeamData:NSDictionary) {
        self.createdAt = TeamData["created_at"] as! String
        self.id = TeamData["id"] as! Int
        self.teamTitle = TeamData["team_title"] as! String
        self.makerId = TeamData["teamjang"] as! Int
        self.teamPassword = TeamData["teampassword"] as! String
        self.updatedAt = TeamData["updated_at"] as! String
    }
}
