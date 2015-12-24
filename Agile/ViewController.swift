//
//  ViewController.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 21..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    
    var selectedRow:Int!
    var toDoList:NSMutableArray = ["하앍", "으앙", "기모찌", "잇쿠욧!!"]
    var doingList:NSMutableArray = ["오메", "지워져랏", "흐어엏", "으아닛!"]
    var doneList:NSMutableArray = ["퍄퍄", "퍄퍄법사짜응", "모 야메룽다", "야메롱!"]
    
    @IBAction func toDoView(sender: UIButton) {
        toDoTableView.hidden = false
        doingTableView.hidden = true
        doneTableView.hidden = true

        NSLog("todo")
    }
    
    @IBAction func doingView(sender: UIButton) {
        toDoTableView.hidden = true
        doingTableView.hidden = false
        doneTableView.hidden = true
        
        NSLog("doing")
    }
    
    @IBAction func doneView(sender: UIButton) {
        toDoTableView.hidden = true
        doingTableView.hidden = true
        doneTableView.hidden = false
        
        NSLog("done")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.hidden = false
        doingTableView.hidden = true
        doneTableView.hidden = true
        
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doneTableView.dataSource = self
        doneTableView.delegate = self
        
        NSLog("toDoList.count = %d", toDoList.count)
        NSLog("doingList.count = %d", doingList.count)
        NSLog("doneList.count = %d", doneList.count)
        
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
                toDoList.removeObjectAtIndex(scrollView.tag)
                scrollView.contentOffset.x = 375
                toDoTableView.reloadData()
            }
        }
        
        else if doingTableView.hidden == false {
            if ((scrollView.contentOffset.x == 375) || (scrollView.contentOffset.x == 750)) && (scrollView.contentOffset.y == 0) {
                
//                doingList.removeObjectAtIndex(scrollView.tag)
//                scrollView.contentOffset.x = 0
//                doingTableView.reloadData()
            }
        }
        
        else if doneTableView.hidden == false {
            if scrollView.contentOffset.x == 375 {
                doneList.removeObjectAtIndex(scrollView.tag)
                scrollView.contentOffset.x = 0
                doneTableView.reloadData()
            }
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
            toDoCell.toDoLabel.text = toDoList.objectAtIndex(indexPath.row) as? String
            toDoCell.toDoScrollView.tag = indexPath.row
            toDoCell.toDoScrollView.delegate = self
            
            cell = toDoCell
        }
            
        else if tableView.isEqual(doingTableView) {
            let doingCell = doingTableView.dequeueReusableCellWithIdentifier("DoingCell") as! DoingTableViewCell!
            doingCell.doingLabel.text = doingList.objectAtIndex(indexPath.row) as? String
            doingCell.doingScrollView.tag = indexPath.row
            doingCell.doingScrollView.delegate = self
            
            cell = doingCell
        }
            
        else if tableView.isEqual(doneTableView) {
            let doneCell = doneTableView.dequeueReusableCellWithIdentifier("DoneCell") as! DoneTableViewCell!
            doneCell.doneLabel.text = doneList.objectAtIndex(indexPath.row) as? String
            doneCell.doneScrollView.tag = indexPath.row
            doneCell.doneScrollView.delegate = self
            
            cell = doneCell
        }
        
        return cell
    }

}

