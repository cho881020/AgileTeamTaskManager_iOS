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
    
    @IBAction func newContent(sender: UIButton) {
        let alertView = UIAlertView()
        alertView.title = "추가할 To Do를 입력해주세요."
        alertView.addButtonWithTitle("Done")
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.addButtonWithTitle("Cancel")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            let content:String = (alertView.textFieldAtIndex(0)?.text)!

            ServerUtil.newContent(GeneralUtil.getUserId() as String, content: content, teamId: GeneralUtil.getTeamId() as String) { (handler) -> Void in
                NSLog("handler = %@", handler)
                
                self.toDoList.removeAllObjects()
                self.doingList.removeAllObjects()
                self.doneList.removeAllObjects()
                
                let contents:NSArray = handler["content"] as! NSArray
                
                for var i = 0; i < contents.count; i++ {
                    let content:NSDictionary = contents[i] as! NSDictionary
                    
                    let contentData:ContentsData = ContentsData(ContentsData: content)
                    let status:NSString = contentData.status
                    
                    if status.isEqualToString("to_do") {
                        self.toDoList.addObject(contentData)
                    }
                    else if status.isEqualToString("doing") {
                        self.doingList.addObject(contentData)
                    }
                    else if status.isEqualToString("done") {
                        self.doneList.addObject(contentData)
                    }
                }
                
                self.toDoTableView.reloadData()
                self.doingTableView.reloadData()
                self.doneTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let content:ContentsData = toDoList.objectAtIndex(scrollView.tag) as! ContentsData
                
                ServerUtil.contentToLeft(String(content.id), teamId: GeneralUtil.getTeamId() as String, userContent: content.userContent, reponseHandler: { (handler) -> Void in
                    NSLog("go to doing")
                    NSLog("handler = %@", handler)
                    
                    self.toDoList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375
                    self.toDoTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let contents:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < contents.count; i++ {
                        let content:NSDictionary = contents[i] as! NSDictionary
                        
                        let contentData:ContentsData = ContentsData(ContentsData: content)
                        let status:NSString = contentData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(contentData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(contentData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(contentData)
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
                let content:ContentsData = doingList.objectAtIndex(scrollView.tag) as! ContentsData
                
                ServerUtil.contentToLeft(String(content.id), teamId: GeneralUtil.getTeamId() as String, userContent: content.userContent, reponseHandler: { (handler) -> Void in
                    NSLog("go to done")
                    NSLog("handler = %@", handler)
                    
                    self.doingList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375
                    
                    self.doingTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let contents:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < contents.count; i++ {
                        let content:NSDictionary = contents[i] as! NSDictionary
                        
                        let contentData:ContentsData = ContentsData(ContentsData: content)
                        let status:NSString = contentData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(contentData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(contentData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(contentData)
                        }
                    }
                    
                    self.toDoTableView.reloadData()
                    self.doingTableView.reloadData()
                    self.doneTableView.reloadData()
                })
            }
            
            else if (scrollView.contentOffset.x == 750) && (scrollView.contentOffset.y == 0) {
                let content:ContentsData = doingList.objectAtIndex(scrollView.tag) as! ContentsData
                NSLog("content = %@", content)
                
                ServerUtil.contentToRight(String(content.id), teamId: GeneralUtil.getTeamId() as String, userContent: content.userContent, reponseHandler: { (handler) -> Void in
                    NSLog("go to to_do")
                    NSLog("handler = %@", handler)
                    
                    self.doingList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 375
                    self.doingTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let contents:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < contents.count; i++ {
                        let content:NSDictionary = contents[i] as! NSDictionary
                        
                        let contentData:ContentsData = ContentsData(ContentsData: content)
                        let status:NSString = contentData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(contentData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(contentData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(contentData)
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
                let content:ContentsData = doneList.objectAtIndex(scrollView.tag) as! ContentsData

                ServerUtil.contentToRight(String(content.id), teamId: GeneralUtil.getTeamId() as String, userContent: content.userContent, reponseHandler: { (handler) -> Void in
                    NSLog("go to doing")
                    NSLog("handler = %@", handler)
                    
                    self.doneList.removeObjectAtIndex(scrollView.tag)
                    scrollView.contentOffset.x = 0
                    self.doneTableView.reloadData()
                    
                    self.toDoList.removeAllObjects()
                    self.doingList.removeAllObjects()
                    self.doneList.removeAllObjects()
                    
                    let contents:NSArray = handler["content"] as! NSArray
                    
                    for var i = 0; i < contents.count; i++ {
                        let content:NSDictionary = contents[i] as! NSDictionary
                        
                        let contentData:ContentsData = ContentsData(ContentsData: content)
                        let status:NSString = contentData.status
                        
                        if status.isEqualToString("to_do") {
                            self.toDoList.addObject(contentData)
                        }
                        else if status.isEqualToString("doing") {
                            self.doingList.addObject(contentData)
                        }
                        else if status.isEqualToString("done") {
                            self.doneList.addObject(contentData)
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
        ServerUtil.loadContents(GeneralUtil.getTeamId() as String) { (handler) -> Void in
            NSLog("handler = %@", handler)
            self.toDoList.removeAllObjects()
            self.doingList.removeAllObjects()
            self.doneList.removeAllObjects()
            
            let contents:NSArray = handler["content"] as! NSArray
            
            for var i = 0; i < contents.count; i++ {
                let content:NSDictionary = contents[i] as! NSDictionary
                
                let contentData:ContentsData = ContentsData(ContentsData: content)
                let status:NSString = contentData.status
                
                if status.isEqualToString("to_do") {
                    self.toDoList.addObject(contentData)
                }
                else if status.isEqualToString("doing") {
                    self.doingList.addObject(contentData)
                }
                else if status.isEqualToString("done") {
                    self.doneList.addObject(contentData)
                }
            }
            
            self.toDoTableView.reloadData()
            self.doingTableView.reloadData()
            self.doneTableView.reloadData()
        }

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
            let toDoDic:ContentsData = (toDoList.objectAtIndex(indexPath.row) as? ContentsData)!
            toDoCell.toDoLabel.text = toDoDic.userContent
            NSLog("toDoCell.toDoLabel = %@", toDoCell.toDoLabel.text!)
            toDoCell.toDoScrollView.tag = indexPath.row
            toDoCell.toDoScrollView.delegate = self
            
            cell = toDoCell
        }
            
        else if tableView.isEqual(doingTableView) {
            let doingCell = doingTableView.dequeueReusableCellWithIdentifier("DoingCell") as! DoingTableViewCell!
            let doingDic:ContentsData = (doingList.objectAtIndex(indexPath.row) as? ContentsData)!
            doingCell.doingLabel.text = doingDic.userContent
            doingCell.doingScrollView.tag = indexPath.row
            doingCell.doingScrollView.delegate = self
            
            cell = doingCell
        }
            
        else if tableView.isEqual(doneTableView) {
            let doneCell = doneTableView.dequeueReusableCellWithIdentifier("DoneCell") as! DoneTableViewCell!
            let doneDic:ContentsData = (doneList.objectAtIndex(indexPath.row) as? ContentsData)!
            doneCell.doneLabel.text = doneDic.userContent
            doneCell.doneScrollView.tag = indexPath.row
            doneCell.doneScrollView.delegate = self
            
            cell = doneCell
        }
        
        return cell
    }

}

