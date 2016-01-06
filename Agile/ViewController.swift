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
    
    var selectedRow:Int!
    var toDoList:NSMutableArray = NSMutableArray()
    var doingList:NSMutableArray = NSMutableArray()
    var doneList:NSMutableArray = NSMutableArray()
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    
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
    
//    @IBAction func newContent(sender: UIButton) {
//        let alertView = UIAlertView()
//        alertView.title = "추가할 To Do를 입력해주세요."
//        alertView.addButtonWithTitle("Done")
//        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
//        alertView.addButtonWithTitle("Cancel")
//        alertView.show()
//        alertView.delegate = self
//        
//        var alertAction = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
////        alertAction.view.addSubview(cardCompanyPickerView)
//        let confirmBtn = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: {(alert: UIAlertAction!) in NSLog("ok")})
//        
//        alertAction.addAction(confirmBtn)
//        
//        self.presentViewController(alertAction, animated: true, completion: {})
//    }
//    
//    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
//        if buttonIndex == 0 {
//            let task:String = (alertView.textFieldAtIndex(0)?.text)!
//
//            ServerUtil.newTask(GeneralUtil.getUserId() as String, userTask: task, projectId: GeneralUtil.getTeamId() as String) { (handler) -> Void in
//                NSLog("handler = %@", handler)
//                
//                self.toDoList.removeAllObjects()
//                self.doingList.removeAllObjects()
//                self.doneList.removeAllObjects()
//                
//                let tasks:NSArray = handler["content"] as! NSArray
//                
//                for var i = 0; i < tasks.count; i++ {
//                    let task:NSDictionary = tasks[i] as! NSDictionary
//                    
//                    let taskData:TaskData = TaskData(TaskData: task)
//                    let status:NSString = taskData.status
//                    
//                    if status.isEqualToString("to_do") {
//                        self.toDoList.addObject(taskData)
//                    }
//                    else if status.isEqualToString("doing") {
//                        self.doingList.addObject(taskData)
//                    }
//                    else if status.isEqualToString("done") {
//                        self.doneList.addObject(taskData)
//                    }
//                }
//                
//                self.toDoTableView.reloadData()
//                self.doingTableView.reloadData()
//                self.doneTableView.reloadData()
//            }
//        }
//    }
    
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
        
        self.doingTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.doneTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        NSLog("toDoList.count = %d", toDoList.count)
        NSLog("doingList.count = %d", doingList.count)
        NSLog("doneList.count = %d", doneList.count)
        
        contentReLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        NSLog("tag = %d", scrollView.tag)
        NSLog("scrollView.contentOffset.x = %f", scrollView.contentOffset.x)
        NSLog("scrollView.contentOffset.y = %f", scrollView.contentOffset.y)
        
        if toDoTableView.hidden == false {
            if (scrollView.contentOffset.x == 0) && (scrollView.contentOffset.y == 0) {
                let task:TaskData = toDoList.objectAtIndex(scrollView.tag) as! TaskData
                
                ServerUtil.taskToLeft(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to doing")
                    NSLog("handler = %@", handler)
                    
                    self.toDoList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375
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
        
        else if doingTableView.hidden == false {
            if (scrollView.contentOffset.x == 0) && (scrollView.contentOffset.y == 0) {
                let task:TaskData = doingList.objectAtIndex(scrollView.tag) as! TaskData
                
                ServerUtil.taskToLeft(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to done")
                    NSLog("handler = %@", handler)
                    
                    self.doingList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375
                    
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
            
            else if (scrollView.contentOffset.x == 750) && (scrollView.contentOffset.y == 0) {
                let task:TaskData = doingList.objectAtIndex(scrollView.tag) as! TaskData
                NSLog("content = %@", task)
                
                ServerUtil.taskToRight(String(task.id), projectId: GeneralUtil.getTeamId() as String, userTask: task.userTask, reponseHandler: { (handler) -> Void in
                    NSLog("go to to_do")
                    NSLog("handler = %@", handler)
                    
                    self.doingList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375
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
        
        else if doneTableView.hidden == false {
            if scrollView.contentOffset.x == 375 {
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
            NSLog("handler = %@", handler)
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
        }

    }
    
    func deleteTask(sender: UIButton) {
        NSLog("tag = %d", sender.tag)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount:Int!
        
        if tableView.isEqual(toDoTableView) {
            rowCount = toDoList.count
        }
            
        else if tableView.isEqual(doingTableView) {
            rowCount = doingList.count
        }
            
        else if tableView.isEqual(doneTableView) {
            rowCount = doneList.count
        }
        
        return rowCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        
        if tableView.isEqual(toDoTableView) {
            let toDoCell = toDoTableView.dequeueReusableCellWithIdentifier("ToDoCell") as! ToDoTableViewCell!
            let toDoDic:TaskData = (toDoList.objectAtIndex(indexPath.row) as? TaskData)!
            toDoCell.toDoLabel.text = toDoDic.userTask
            toDoCell.toDoScrollView.tag = indexPath.row
            toDoCell.toDoScrollView.delegate = self
            
            if GeneralUtil.getUserId().isEqualToString(String(toDoDic.userId)) == false {
                toDoCell.toDoScrollView.userInteractionEnabled = false
            }
            
            let profileFrontURL:String = "https://graph.facebook.com/"
            let profileBackURL:String = "/picture?type=normal"
            var profileURL:String = String()
            profileURL = profileURL.stringByAppendingString(profileFrontURL)
            profileURL = profileURL.stringByAppendingString(toDoDic.uId)
            profileURL = profileURL.stringByAppendingString(profileBackURL)
            toDoCell.profileImage.setImageWithURL(NSURL(string: profileURL))
            
            toDoCell.userName.text = toDoDic.userName
            toDoCell.endLabel.frame.origin.x = 10 * widthRate
            toDoCell.endLabel.frame.origin.y = 100 * heightRate
            toDoCell.endLabel.frame.size.width = 355 * widthRate
            toDoCell.endLabel.frame.size.height = 1
            
            cell = toDoCell
        }
            
        else if tableView.isEqual(doingTableView) {
            let doingCell = doingTableView.dequeueReusableCellWithIdentifier("DoingCell") as! DoingTableViewCell!
            let doingDic:TaskData = (doingList.objectAtIndex(indexPath.row) as? TaskData)!
            doingCell.doingLabel.text = doingDic.userTask
            doingCell.doingScrollView.tag = indexPath.row
            doingCell.doingScrollView.delegate = self
            
            if GeneralUtil.getUserId().isEqualToString(String(doingDic.userId)) == false {
                doingCell.doingScrollView.userInteractionEnabled = false
            }
            
            let profileFrontURL:String = "https://graph.facebook.com/"
            let profileBackURL:String = "/picture?type=normal"
            var profileURL:String = String()
            profileURL = profileURL.stringByAppendingString(profileFrontURL)
            profileURL = profileURL.stringByAppendingString(doingDic.uId)
            profileURL = profileURL.stringByAppendingString(profileBackURL)
            doingCell.profileImage.setImageWithURL(NSURL(string: profileURL))
            
            doingCell.userName.text = doingDic.userName
            doingCell.endLabel.frame.origin.x = 10 * widthRate
            doingCell.endLabel.frame.origin.y = 100 * heightRate
            doingCell.endLabel.frame.size.width = 355 * widthRate
            doingCell.endLabel.frame.size.height = 1
            
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
            
            if GeneralUtil.getUserId().isEqualToString(String(doneDic.userId)) == false {
                doneCell.doneScrollView.userInteractionEnabled = false
            }
            
            let profileFrontURL:String = "https://graph.facebook.com/"
            let profileBackURL:String = "/picture?type=normal"
            var profileURL:String = String()
            profileURL = profileURL.stringByAppendingString(profileFrontURL)
            profileURL = profileURL.stringByAppendingString(doneDic.uId)
            profileURL = profileURL.stringByAppendingString(profileBackURL)
            doneCell.profileImage.setImageWithURL(NSURL(string: profileURL))
            doneCell.profileImage.frame.origin.x = 10 * widthRate
            doneCell.profileImage.frame.origin.y = 5  * heightRate
            doneCell.profileImage.frame.size.width = 35 * widthRate
            doneCell.profileImage.frame.size.height = 35 * heightRate
            
            doneCell.userName.frame.origin.x = 55 * widthRate
            doneCell.userName.frame.origin.y = 12  * heightRate
            doneCell.userName.frame.size.width = 150 * widthRate
            doneCell.userName.frame.size.height = 21 * heightRate
            doneCell.userName.text = doneDic.userName
            
            doneCell.endLabel.frame.origin.x = 10 * widthRate
            doneCell.endLabel.frame.origin.y = 100 * heightRate
            doneCell.endLabel.frame.size.width = 355 * widthRate
            doneCell.endLabel.frame.size.height = 1
            
            doneCell.deleteTaskBtn.frame.origin.x = 326 * widthRate
            doneCell.deleteTaskBtn.frame.origin.y = 12 * heightRate
            doneCell.deleteTaskBtn.frame.size.width = 21 * widthRate
            doneCell.deleteTaskBtn.frame.size.height = 21 * heightRate
            
            doneCell.deleteBtn.tag = indexPath.row
            doneCell.deleteBtn.frame.origin.x = 326 * widthRate
            doneCell.deleteBtn.frame.origin.y = 12 * heightRate
            doneCell.deleteBtn.frame.size.width = 21 * widthRate
            doneCell.deleteBtn.frame.size.height = 21 * heightRate
            NSLog("tag = %d", doneCell.deleteBtn.tag)
            doneCell.deleteBtn.addTarget(self, action: "deleteTask:", forControlEvents: UIControlEvents.TouchUpInside)
            
            cell = doneCell
        }
        
        tableView.rowHeight = 101 * heightRate
        
        return cell
    }

}

