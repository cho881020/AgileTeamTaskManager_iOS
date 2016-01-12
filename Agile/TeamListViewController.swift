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
    @IBOutlet weak var revealBtn: UIButton!
    
    var projectList:NSMutableArray = NSMutableArray()
    var belongList:NSMutableArray = NSMutableArray()
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    
    @IBAction func teamAddBtn(sender: UIButton) {
        let alertView = UIAlertView()
        alertView.title = "방 만들기"
        alertView.addButtonWithTitle("Done")
        alertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
        alertView.textFieldAtIndex(0)?.placeholder = "생성할 팀의 이름을 입력해주세요."
        alertView.textFieldAtIndex(1)?.placeholder = "비밀번호를 입력해주세요."
        alertView.addButtonWithTitle("Cancel")
        alertView.show()
        alertView.delegate = self
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            let projectTitle:String = (alertView.textFieldAtIndex(0)?.text)!
            let password:String = (alertView.textFieldAtIndex(1)?.text)!
            ServerUtil.creatProject(projectTitle, password: password, userId: GeneralUtil.getUserId() as String, reponseHandler: { (handler) -> Void in
                NSLog("handler = %@", handler)
            })
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthRate = UIScreen.mainScreen().bounds.width / 375
        heightRate = UIScreen.mainScreen().bounds.height / 667
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        NSLog("projectLoad")
        projectLoad()
    }
    
    func projectLoad() {
        ServerUtil.loadProjectList(GeneralUtil.getUserId() as String) { (handler) -> Void in
            NSLog("handler = %@", handler)
            
            self.projectList.removeAllObjects()
            self.belongList.removeAllObjects()
            
            let madeProject:NSArray = handler["jangteam"] as! NSArray
            let belongProject:NSArray = handler["sokteam"] as! NSArray
            
            for var i = 0; i < madeProject.count; i++ {
                let project:NSDictionary = madeProject[i] as! NSDictionary
                let projectData:ProjectData = ProjectData(ProjectData: project)
                
                self.projectList.addObject(projectData)
                
            }
            
            for var i = 0; i < belongProject.count; i++ {
                let project:NSDictionary = belongProject[i] as! NSDictionary
                let projectData:ProjectData = ProjectData(ProjectData: project)
                
                self.belongList.addObject(projectData)
            }
            
            self.teamTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount:Int = 0
        if section == 0 {
            if projectList.count != 0 {
                rowCount = projectList.count
            }
        }
        else if section == 1 {
            if belongList.count != 0 {
                rowCount = belongList.count
            }
        }
        return rowCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        NSLog("cellForRowAtIndexPath")
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("teamListCell")! as UITableViewCell
        
        let projectData:ProjectData!
        
        let projectLabel:UILabel = cell.viewWithTag(1) as! UILabel
        if indexPath.section == 0 {
            projectData = projectList.objectAtIndex(indexPath.row) as! ProjectData
            projectLabel.text = projectData.projectTitle as String
        }
        else if indexPath.section == 1 {
            projectData = belongList.objectAtIndex(indexPath.row) as! ProjectData
            projectLabel.text = projectData.projectTitle as String
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let projectData:ProjectData!
        if indexPath.section == 0 {
            projectData = projectList.objectAtIndex(indexPath.row) as! ProjectData
            GeneralUtil.setTeamId(String(projectData.id as Int))
        }
        else if indexPath.section == 1 {
            projectData = belongList.objectAtIndex(indexPath.row) as! ProjectData
            GeneralUtil.setTeamId(String(projectData.id as Int))
        }
        performSegueWithIdentifier("contentsSegue", sender: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        NSLog("viewForHeaderInSection")
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
