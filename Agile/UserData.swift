//
//  UserData.swift
//  Agile
//
//  Created by KJ Studio on 2016. 1. 13..
//  Copyright © 2016년 KJStudio. All rights reserved.
//

import Foundation

class UserData: NSObject {
    var id:Int!
    var uId:String!
    var userName:String!
    
    init(UserData:NSDictionary) {
        self.id = UserData["id"] as! Int
        self.uId = UserData["uid"] as! String!
        self.userName = UserData["name"] as! String!
    }
}
