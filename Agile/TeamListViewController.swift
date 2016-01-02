//
//  TeamListViewController.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 28..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var teamTableView: UITableView!
    
    var teamList:NSMutableArray = NSMutableArray()
    var belongList:NSMutableArray = NSMutableArray()
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("asdf")
        
        widthRate = UIScreen.mainScreen().bounds.width / 375
        heightRate = UIScreen.mainScreen().bounds.height / 667
        
        teamList.removeAllObjects()
        belongList.removeAllObjects()
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        
        ServerUtil.loadTeamList(GeneralUtil.getUserId() as String) { (handler) -> Void in
            NSLog("handler = %@", handler)
            
            let madeTeam:NSArray = handler["jangteam"] as! NSArray
            let belongTeam:NSArray = handler["sokteam"] as! NSArray
            
            for var i = 0; i < madeTeam.count; i++ {
                let team:NSDictionary = madeTeam[i] as! NSDictionary
                let teamData:TeamData = TeamData(TeamData: team)
                
                self.teamList.addObject(teamData)
                
            }
            
            for var i = 0; i < belongTeam.count; i++ {
//                NSLog("ggg")
//                let team:NSDictionary = belongTeam[i] as! NSDictionary
//                let teamData:TeamData = TeamData(TeamData: team)
            
                self.belongList.addObject(1)
            }
            
            self.teamTableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount:Int!
        if section == 0 {
            rowCount = teamList.count
        }
        else if section == 1 {
            rowCount = belongList.count
        }
        return rowCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("teamListCell")! as UITableViewCell
        
        let teamData:TeamData!
        
        let teamLabel:UILabel = cell.viewWithTag(1) as! UILabel
        if indexPath.section == 0 {
            teamData = teamList.objectAtIndex(indexPath.row) as! TeamData
            teamLabel.text = teamData.teamTitle as String
        }
        else if indexPath.section == 1 {
//            teamData = belongList.objectAtIndex(indexPath.row) as! TeamData
//            teamLabel.text = teamData.teamTitle as String
            teamLabel.text = "으아앙"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("contentsSegue", sender: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as UITableViewCell!
        
        let headerTitle:UILabel = header.viewWithTag(10) as! UILabel
        headerTitle.frame.origin.x = 15 * widthRate
        headerTitle.frame.origin.y = 4 * heightRate
        headerTitle.frame.size.width = 200 * widthRate
        headerTitle.frame.size.height = 21 * heightRate
        
        if section == 0 {
            headerTitle.text = "내가 만든 팀"
            
        }
        else if section == 1 {
            headerTitle.text = "내가 속한 팀"
            
        }
        
        headerTitle.font = UIFont.systemFontOfSize(15 * widthRate)
        
        return header
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 * heightRate
    }
}
