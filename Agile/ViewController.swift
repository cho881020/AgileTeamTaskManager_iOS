//
//  ViewController.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 21..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var revealBtn: UIButton!
    
    var selectedRow:Int!
    var toDoList:NSMutableArray = NSMutableArray()
    var doingList:NSMutableArray = NSMutableArray()
    var doneList:NSMutableArray = NSMutableArray()
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    var teamUserList:NSMutableArray = NSMutableArray()
    var toDoCountedList:NSMutableArray = NSMutableArray()
    var doingCountedList:NSMutableArray = NSMutableArray()
    var doneCountedList:NSMutableArray = NSMutableArray()
    
    @IBAction func toDoView(sender: UIButton) {
        toDoTableView.hidden = false
        doingTableView.hidden = true
        doneTableView.hidden = true
        
        self.navigationItem.title = "To Do"
        
        NSLog("todo")
    }
    
    @IBAction func doingView(sender: UIButton) {
        toDoTableView.hidden = true
        doingTableView.hidden = false
        doneTableView.hidden = true
        
        self.navigationItem.title = "Doing"
        
        NSLog("doing")
    }
    
    @IBAction func doneView(sender: UIButton) {
        toDoTableView.hidden = true
        doingTableView.hidden = true
        doneTableView.hidden = false
        
        self.navigationItem.title = "Done"
        
        NSLog("done")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthRate = UIScreen.mainScreen().bounds.width / 375
        heightRate = UIScreen.mainScreen().bounds.height / 667
        
        self.navigationItem.title = "To Do"
        
        toDoList.removeAllObjects()
        doingList.removeAllObjects()
        doneList.removeAllObjects()
        
        toDoTableView.hidden = false
        doingTableView.hidden = true
        doneTableView.hidden = true
        
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        
        doingTableView.dataSource = self
        doingTableView.delegate = self
        
        doneTableView.dataSource = self
        doneTableView.delegate = self
        
        toDoTableView.contentInset = UIEdgeInsets(top: 64 * heightRate, left: 0, bottom: 0, right: 0)
        doingTableView.contentInset = UIEdgeInsets(top: 64 * heightRate, left: 0, bottom: 0, right: 0)
        doneTableView.contentInset = UIEdgeInsets(top: 64 * heightRate, left: 0, bottom: 0, right: 0)
        
        GeneralUtil.setTeamId(String(30))
        
        NSLog("toDoList.count = %d", toDoList.count)
        NSLog("doingList.count = %d", doingList.count)
        NSLog("doneList.count = %d", doneList.count)
        
        self.revealViewController().rearViewRevealWidth = 260 * widthRate
        self.revealViewController().tapGestureRecognizer()
        revealBtn.addTarget(self, action: "revealView", forControlEvents: UIControlEvents.TouchUpInside)
        
        ServerUtil.teaminfo(GeneralUtil.getTeamId() as String) { (handler) -> Void in
            NSLog("handler = %@", handler)
            
            self.teamUserList.removeAllObjects()
            
            let userInfo:NSArray = handler["userinfo"] as! NSArray
            let descriptor:NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            let sortedUsers:NSArray = userInfo.sortedArrayUsingDescriptors([descriptor])
            let filterUsers:NSMutableArray = NSMutableArray()
            for var i = 0; i < sortedUsers.count; i++ {
                let user:NSDictionary = sortedUsers[i] as! NSDictionary
                let userData:UserData = UserData(UserData: user)
                
                NSLog("userName = %@", userData.userName)
                if userData.userName == GeneralUtil.getUserName() {
                    self.teamUserList.addObject(userData)
                }
                else {
                    filterUsers.addObject(userData)
                }
            }
            for var i:Int = 0; i < filterUsers.count; i++ {
                self.teamUserList.addObject(filterUsers[i] as! UserData)
            }
        }
        
        contentReLoad()
        
    }
    
    func revealView() {
        self.revealViewController().revealToggle(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        NSLog("tag = %d", scrollView.tag)
        
        NSLog("scrollView.contentOffset.x = %f", scrollView.contentOffset.x)
        NSLog("scrollView.contentOffset.y = %f", scrollView.contentOffset.y)
        
        if (toDoTableView.hidden == false) && (doingTableView.hidden == true) && (doneTableView.hidden == true) {
            if (scrollView.contentOffset.x == 0) && (scrollView.contentOffset.y == 0) {
                let task:TaskData = toDoList.objectAtIndex(scrollView.tag) as! TaskData
                
                ServerUtil.taskToLeft(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to doing")
                    NSLog("handler = %@", handler)
                    
                    self.toDoList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375 * self.widthRate
                    self.toDoTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let tasks:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < tasks.count; i++ {
                        let task:NSDictionary = tasks[i] as! NSDictionary
                        
                        let taskData:TaskData = TaskData(TaskData: task)
                        let status:NSString = taskData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(taskData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(taskData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(taskData)
                        }
                    }
                    
                    self.toDoTableView.reloadData()
                    self.doingTableView.reloadData()
                    self.doneTableView.reloadData()
                })
            }
        }
        
        else if (toDoTableView.hidden == true) && (doingTableView.hidden == false) && (doneTableView.hidden == true) {
            if (scrollView.contentOffset.x == 0) && (scrollView.contentOffset.y == 0) {
                let task:TaskData = doingList.objectAtIndex(scrollView.tag) as! TaskData
                
                ServerUtil.taskToLeft(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to done")
                    NSLog("handler = %@", handler)
                    
                    self.doingList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375 * self.widthRate
                    
                    self.doingTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let tasks:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < tasks.count; i++ {
                        let task:NSDictionary = tasks[i] as! NSDictionary
                        
                        let taskData:TaskData = TaskData(TaskData: task)
                        let status:NSString = taskData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(taskData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(taskData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(taskData)
                        }
                    }
                    
                    self.toDoTableView.reloadData()
                    self.doingTableView.reloadData()
                    self.doneTableView.reloadData()
                })
            }
            
            else if (scrollView.contentOffset.x == 750 * widthRate) && (scrollView.contentOffset.y == 0) {
                let task:TaskData = doingList.objectAtIndex(scrollView.tag) as! TaskData
                NSLog("content = %@", task)
                
                ServerUtil.taskToRight(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to to_do")
                    NSLog("handler = %@", handler)
                    
                    self.doingList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375 * self.widthRate
                    self.doingTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let tasks:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < tasks.count; i++ {
                        let task:NSDictionary = tasks[i] as! NSDictionary
                        
                        let taskData:TaskData = TaskData(TaskData: task)
                        let status:NSString = taskData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(taskData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(taskData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(taskData)
                        }
                    }
                    
                    self.toDoTableView.reloadData()
                    self.doingTableView.reloadData()
                    self.doneTableView.reloadData()
                })
            }
        }
        
        else if (toDoTableView.hidden == true) && (doingTableView.hidden == true) && (doneTableView.hidden == false) {
            if scrollView.contentOffset.x == 375 * widthRate {
                let task:TaskData = doneList.objectAtIndex(scrollView.tag) as! TaskData

                ServerUtil.taskToRight(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to doing")
                    NSLog("handler = %@", handler)
                    
                    self.doneList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 0
                    self.doneTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let tasks:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < tasks.count; i++ {
                        let task:NSDictionary = tasks[i] as! NSDictionary
                        
                        let taskData:TaskData = TaskData(TaskData: task)
                        let status:NSString = taskData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(taskData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(taskData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(taskData)
                        }
                    }
                    
                    self.toDoTableView.reloadData()
                    self.doingTableView.reloadData()
                    self.doneTableView.reloadData()
                })
            }
        }
        
    }
    
    func contentReLoad() {
        ServerUtil.loadTasks(GeneralUtil.getTeamId() as String) { (handler) -> Void in
//            NSLog("handler = %@", handler)
            self.toDoList.removeAllObjects()
            self.doingList.removeAllObjects()
            self.doneList.removeAllObjects()
            
            let tasks:NSArray = handler["content"] as! NSArray
            let descriptor:NSSortDescriptor = NSSortDescriptor(key: "username", ascending: true)
            let sortedTasks:NSArray = tasks.sortedArrayUsingDescriptors([descriptor])
            let filterTasks:NSMutableArray = NSMutableArray()
            for var i = 0; i < sortedTasks.count; i++ {
                let task:NSDictionary = sortedTasks[i] as! NSDictionary
                let taskData:TaskData = TaskData(TaskData: task)
                
                if taskData.userName == GeneralUtil.getUserName() {
                    let status:NSString = taskData.status
                    
                    if status.isEqualToString("to_do") {
                        self.toDoList.addObject(taskData)
                    }
                    else if status.isEqualToString("doing") {
                        self.doingList.addObject(taskData)
                    }
                    else if status.isEqualToString("done") {
                        self.doneList.addObject(taskData)
                    }
                }
                else {
                    filterTasks.addObject(sortedTasks[i])
                }
            }
            self.toDoCountedList.addObject(self.toDoList.count)
            self.doingCountedList.addObject(self.doingList.count)
            self.doneCountedList.addObject(self.doneList.count)
            var j:Int = 0;
            
            for var i = 0; i < filterTasks.count; i++ {
                var task:NSDictionary = filterTasks[i] as! NSDictionary
                let taskData:TaskData = TaskData(TaskData: task)
                
                if i != 0 {
                    task = filterTasks[i-1] as! NSDictionary
                    let pastTaskData:TaskData = TaskData(TaskData: task)
                    
                    if (taskData.userName != pastTaskData.userName) {
                        self.toDoCountedList.addObject(self.toDoList.count - (self.toDoCountedList[j] as! Int))
                        self.doingCountedList.addObject(self.doingList.count - (self.doingCountedList[j] as! Int))
                        self.doneCountedList.addObject(self.doneList.count - (self.doneCountedList[j] as! Int))
                        j++
                    }
                }
                
                NSLog("sorted username = %@", taskData.userName)
                let status:NSString = taskData.status
                
                if status.isEqualToString("to_do") {
                    self.toDoList.addObject(taskData)
                }
                else if status.isEqualToString("doing") {
                    self.doingList.addObject(taskData)
                }
                else if status.isEqualToString("done") {
                    self.doneList.addObject(taskData)
                }
                
                if i == (filterTasks.count - 1) {
                    self.toDoCountedList.addObject(self.toDoList.count - (self.toDoCountedList[j] as! Int))
                    self.doingCountedList.addObject(self.doingList.count - (self.doingCountedList[j] as! Int))
                    self.doneCountedList.addObject(self.doneList.count - (self.doneCountedList[j] as! Int))
                    j++
                    if j < (self.teamUserList.count - 1) {
                        for var i:Int = j; i < self.teamUserList.count; i++ {
                            self.toDoCountedList.addObject(0)
                            self.doingCountedList.addObject(0)
                            self.doneCountedList.addObject(0)
                        }
                    }
                }
            }
            
            self.toDoTableView.reloadData()
            self.doingTableView.reloadData()
            self.doneTableView.reloadData()
        }

    }
    
    func deleteTask(sender: UIButton) {
        NSLog("deletetag = %d", sender.tag)
        var task:TaskData!
        if (toDoTableView.hidden == false) && (doingTableView.hidden == true) && (doneTableView.hidden == true) {
            task = toDoList.objectAtIndex(sender.tag) as! TaskData
        }
        else if (toDoTableView.hidden == true) && (doingTableView.hidden == false) && (doneTableView.hidden == true) {
            task = doingList.objectAtIndex(sender.tag) as! TaskData
        }
        else if (toDoTableView.hidden == true) && (doingTableView.hidden == true) && (doneTableView.hidden == false) {
            task = doneList.objectAtIndex(sender.tag) as! TaskData
        }
        ServerUtil.deleteTask(String(task.id)) { (handler) -> Void in
            NSLog("handler = %@", handler)
            self.contentReLoad()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return teamUserList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount:Int!
        
        for var i:Int = 0; i < teamUserList.count; i++ {
            if section == i {
                if tableView.isEqual(toDoTableView) {
                    rowCount = toDoCountedList[i] as! Int
                }
                    
                else if tableView.isEqual(doingTableView) {
                    rowCount = doingCountedList[i] as! Int
                }
                    
                else if tableView.isEqual(doneTableView) {
                    rowCount = doneCountedList[i] as! Int
                }
            }
        }
        
        return rowCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        
        if tableView.isEqual(toDoTableView) {
            let toDoCell = toDoTableView.dequeueReusableCellWithIdentifier("ToDoCell") as! ToDoTableViewCell!
            let toDoDic:TaskData = (toDoList.objectAtIndex(indexPath.row) as? TaskData)!
            toDoCell.toDoLabel.frame.origin.x = 390 * widthRate
            toDoCell.toDoLabel.frame.origin.y = 45  * heightRate
            toDoCell.toDoLabel.frame.size.width = 345 * widthRate
            toDoCell.toDoLabel.frame.size.height = 20 * heightRate
            toDoCell.toDoLabel.text = toDoDic.userTask
            toDoCell.toDoScrollView.tag = indexPath.row
            toDoCell.toDoScrollView.delegate = self
            
//            let profileFrontURL:String = "https://graph.facebook.com/"
//            let profileBackURL:String = "/picture?type=normal"
//            var profileURL:String = String()
//            profileURL = profileURL.stringByAppendingString(profileFrontURL)
//            profileURL = profileURL.stringByAppendingString(toDoDic.uId)
//            profileURL = profileURL.stringByAppendingString(profileBackURL)
//            toDoCell.profileImage.setImageWithURL(NSURL(string: profileURL))
//            toDoCell.profileImage.frame.origin.x = 385 * widthRate
//            toDoCell.profileImage.frame.origin.y = 5  * heightRate
//            toDoCell.profileImage.frame.size.width = 35 * widthRate
//            toDoCell.profileImage.frame.size.height = 35 * heightRate
//            
//            toDoCell.userName.frame.origin.x = 430 * widthRate
//            toDoCell.userName.frame.origin.y = 12  * heightRate
//            toDoCell.userName.frame.size.width = 150 * widthRate
//            toDoCell.userName.frame.size.height = 21 * heightRate
//            toDoCell.userName.text = toDoDic.userName
            
            toDoCell.endLabel.frame.origin.x = 10 * widthRate
            toDoCell.endLabel.frame.origin.y = 100 * heightRate
            toDoCell.endLabel.frame.size.width = 355 * widthRate
            toDoCell.endLabel.frame.size.height = 1
            
            toDoCell.deleteBtn.tag = indexPath.row
            toDoCell.deleteBtn.frame.origin.x = 701 * widthRate
            toDoCell.deleteBtn.frame.origin.y = 12 * heightRate
            toDoCell.deleteBtn.frame.size.width = 21 * widthRate
            toDoCell.deleteBtn.frame.size.height = 21 * heightRate
            toDoCell.deleteBtn.addTarget(self, action: "deleteTask:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if GeneralUtil.getUserId().isEqualToString(String(toDoDic.userId)) == false {
                toDoCell.toDoScrollView.userInteractionEnabled = false
                toDoCell.deleteBtn.hidden = false
            }
            else {
                toDoCell.toDoScrollView.userInteractionEnabled = true
                toDoCell.deleteBtn.hidden = false
            }
            
            if indexPath.row % 2 == 1 {
                toDoCell.toDoContentView.backgroundColor = UIColor.lightGrayColor()
            }
            else {
                toDoCell.toDoContentView.backgroundColor = UIColor.whiteColor()
            }
            
            cell = toDoCell
        }
            
        else if tableView.isEqual(doingTableView) {
            let doingCell = doingTableView.dequeueReusableCellWithIdentifier("DoingCell") as! DoingTableViewCell!
            let doingDic:TaskData = (doingList.objectAtIndex(indexPath.row) as? TaskData)!
            doingCell.doingLabel.frame.origin.x = 390 * widthRate
            doingCell.doingLabel.frame.origin.y = 45  * heightRate
            doingCell.doingLabel.frame.size.width = 345 * widthRate
            doingCell.doingLabel.frame.size.height = 20 * heightRate
            doingCell.doingLabel.text = doingDic.userTask
            doingCell.doingScrollView.tag = indexPath.row
            doingCell.doingScrollView.delegate = self
            
//            let profileFrontURL:String = "https://graph.facebook.com/"
//            let profileBackURL:String = "/picture?type=normal"
//            var profileURL:String = String()
//            profileURL = profileURL.stringByAppendingString(profileFrontURL)
//            profileURL = profileURL.stringByAppendingString(doingDic.uId)
//            profileURL = profileURL.stringByAppendingString(profileBackURL)
//            doingCell.profileImage.setImageWithURL(NSURL(string: profileURL))
//            doingCell.profileImage.frame.origin.x = 385 * widthRate
//            doingCell.profileImage.frame.origin.y = 5  * heightRate
//            doingCell.profileImage.frame.size.width = 35 * widthRate
//            doingCell.profileImage.frame.size.height = 35 * heightRate
//            
//            doingCell.userName.frame.origin.x = 430 * widthRate
//            doingCell.userName.frame.origin.y = 12  * heightRate
//            doingCell.userName.frame.size.width = 150 * widthRate
//            doingCell.userName.frame.size.height = 21 * heightRate
//            doingCell.userName.text = doingDic.userName
            
            doingCell.endLabel.frame.origin.x = 10 * widthRate
            doingCell.endLabel.frame.origin.y = 100 * heightRate
            doingCell.endLabel.frame.size.width = 355 * widthRate
            doingCell.endLabel.frame.size.height = 1
            
            doingCell.deleteBtn.tag = indexPath.row
            doingCell.deleteBtn.frame.origin.x = 701 * widthRate
            doingCell.deleteBtn.frame.origin.y = 12 * heightRate
            doingCell.deleteBtn.frame.size.width = 21 * widthRate
            doingCell.deleteBtn.frame.size.height = 21 * heightRate
            doingCell.deleteBtn.addTarget(self, action: "deleteTask:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if GeneralUtil.getUserId().isEqualToString(String(doingDic.userId)) == false {
                doingCell.doingScrollView.userInteractionEnabled = false
                doingCell.deleteBtn.hidden = true
            }
            else {
                doingCell.doingScrollView.userInteractionEnabled = true
                doingCell.deleteBtn.hidden = false
            }
            
            if indexPath.row % 2 == 1 {
                doingCell.doingContentView.backgroundColor = UIColor.lightGrayColor()
            }
            else {
                doingCell.doingContentView.backgroundColor = UIColor.whiteColor()
            }
            
            cell = doingCell
        }
            
        else if tableView.isEqual(doneTableView) {
            let doneCell = doneTableView.dequeueReusableCellWithIdentifier("DoneCell") as! DoneTableViewCell!
            let doneDic:TaskData = (doneList.objectAtIndex(indexPath.row) as? TaskData)!
            doneCell.doneLabel.frame.origin.x = 15 * widthRate
            doneCell.doneLabel.frame.origin.y = 45  * heightRate
            doneCell.doneLabel.frame.size.width = 345 * widthRate
            doneCell.doneLabel.frame.size.height = 20 * heightRate
            doneCell.doneLabel.text = doneDic.userTask
            doneCell.doneScrollView.tag = indexPath.row
            doneCell.doneScrollView.delegate = self

            doneCell.endLabel.frame.origin.x = 10 * widthRate
            doneCell.endLabel.frame.origin.y = 100 * heightRate
            doneCell.endLabel.frame.size.width = 355 * widthRate
            doneCell.endLabel.frame.size.height = 1
            
            doneCell.deleteBtn.tag = indexPath.row
            doneCell.deleteBtn.frame.origin.x = 326 * widthRate
            doneCell.deleteBtn.frame.origin.y = 12 * heightRate
            doneCell.deleteBtn.frame.size.width = 21 * widthRate
            doneCell.deleteBtn.frame.size.height = 21 * heightRate
            doneCell.deleteBtn.addTarget(self, action: "deleteTask:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if GeneralUtil.getUserId().isEqualToString(String(doneDic.userId)) == false {
                doneCell.doneScrollView.userInteractionEnabled = false
                doneCell.deleteBtn.hidden = true
            }
            else {
                doneCell.doneScrollView.userInteractionEnabled = true
                doneCell.deleteBtn.hidden = false
            }
            
            if indexPath.row % 2 == 1 {
                doneCell.doneContentView.backgroundColor = UIColor.lightGrayColor()
            }
            else {
                doneCell.doneContentView.backgroundColor = UIColor.whiteColor()
            }
            
            cell = doneCell
        }
        
        tableView.rowHeight = 101 * heightRate
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header:UITableViewCell!
        for var i:Int = 0; i < teamUserList.count; i++ {
            let userData:UserData = teamUserList[i] as! UserData
            if section == i {
                if tableView.isEqual(toDoTableView) {
                    let toDoHeader = tableView.dequeueReusableCellWithIdentifier("toDoHeaderCell")
                    
                    let profileImage:UIImageView = toDoHeader?.viewWithTag(1) as! UIImageView
                    let profileFrontURL:String = "https://graph.facebook.com/"
                    let profileBackURL:String = "/picture?type=normal"
                    var profileURL:String = String()
                    profileURL = profileURL.stringByAppendingString(profileFrontURL)
                    profileURL = profileURL.stringByAppendingString(userData.uId)
                    profileURL = profileURL.stringByAppendingString(profileBackURL)
                    profileImage.setImageWithURL(NSURL(string: profileURL))
                    profileImage.frame.origin.x = 10 * widthRate
                    profileImage.frame.origin.y = 15  * heightRate
                    profileImage.frame.size.width = 30 * widthRate
                    profileImage.frame.size.height = 30 * heightRate
                    profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
                    profileImage.layer.masksToBounds = false
                    profileImage.clipsToBounds = true
                    
                    let userName:UILabel = toDoHeader?.viewWithTag(2) as! UILabel
                    userName.frame.origin.x = 55 * widthRate
                    userName.frame.origin.y = 20  * heightRate
                    userName.frame.size.width = 150 * widthRate
                    userName.frame.size.height = 20 * heightRate
                    userName.text = userData.userName
                    
                    header = toDoHeader
                }
                else if tableView.isEqual(doingTableView) {
                    let doingHeader = tableView.dequeueReusableCellWithIdentifier("doingHeaderCell")
                    
                    let profileImage:UIImageView = doingHeader?.viewWithTag(1) as! UIImageView
                    let profileFrontURL:String = "https://graph.facebook.com/"
                    let profileBackURL:String = "/picture?type=normal"
                    var profileURL:String = String()
                    profileURL = profileURL.stringByAppendingString(profileFrontURL)
                    profileURL = profileURL.stringByAppendingString(userData.uId)
                    profileURL = profileURL.stringByAppendingString(profileBackURL)
                    profileImage.setImageWithURL(NSURL(string: profileURL))
                    profileImage.frame.origin.x = 10 * widthRate
                    profileImage.frame.origin.y = 15  * heightRate
                    profileImage.frame.size.width = 30 * widthRate
                    profileImage.frame.size.height = 30 * heightRate
                    profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
                    profileImage.layer.masksToBounds = false
                    profileImage.clipsToBounds = true
                    
                    let userName:UILabel = doingHeader?.viewWithTag(2) as! UILabel
                    userName.frame.origin.x = 55 * widthRate
                    userName.frame.origin.y = 20  * heightRate
                    userName.frame.size.width = 150 * widthRate
                    userName.frame.size.height = 20 * heightRate
                    userName.text = userData.userName
                    
                    header = doingHeader
                }
                else if tableView.isEqual(doneTableView) {
                    let doneHeader = tableView.dequeueReusableCellWithIdentifier("doneHeaderCell")
                    
                    let profileImage:UIImageView = doneHeader?.viewWithTag(1) as! UIImageView
                    let profileFrontURL:String = "https://graph.facebook.com/"
                    let profileBackURL:String = "/picture?type=normal"
                    var profileURL:String = String()
                    profileURL = profileURL.stringByAppendingString(profileFrontURL)
                    profileURL = profileURL.stringByAppendingString(userData.uId)
                    profileURL = profileURL.stringByAppendingString(profileBackURL)
                    profileImage.setImageWithURL(NSURL(string: profileURL))
                    profileImage.frame.origin.x = 10 * widthRate
                    profileImage.frame.origin.y = 15  * heightRate
                    profileImage.frame.size.width = 30 * widthRate
                    profileImage.frame.size.height = 30 * heightRate
                    profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
                    profileImage.layer.masksToBounds = false
                    profileImage.clipsToBounds = true
                    
                    let userName:UILabel = doneHeader?.viewWithTag(2) as! UILabel
                    userName.frame.origin.x = 55 * widthRate
                    userName.frame.origin.y = 20  * heightRate
                    userName.frame.size.width = 150 * widthRate
                    userName.frame.size.height = 20 * heightRate
                    userName.text = userData.userName
                    
                    header = doneHeader
                }
            }
        }
        
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60 * heightRate
    }

}

