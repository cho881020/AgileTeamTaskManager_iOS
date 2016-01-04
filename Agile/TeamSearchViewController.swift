//
//  TeamSearchViewController.swift
//  Agile
//
//  Created by KJ Studio on 2016. 1. 2..
//  Copyright © 2016년 KJStudio. All rights reserved.
//

import UIKit

class TeamSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    var allProjectList:NSMutableArray = NSMutableArray()
    var projectList:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        allProjectList.removeAllObjects()
        
        ServerUtil.getAllProject(GeneralUtil.getUserId() as String) { (handler) -> Void in
            NSLog("handler = %@", handler)
            
            let projects:NSArray = handler["allTeam"] as! NSArray
            for var i:Int = 0; i < projects.count; i++ {
                let project:NSDictionary = projects.objectAtIndex(i) as! NSDictionary
                let projectData:ProjectData = ProjectData(ProjectData: project)
                
                self.allProjectList.addObject(projectData)
                self.projectList.addObject(projectData)
            }
            
            self.searchTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editTextField(sender: UITextField) {
        if sender.text!.isEmpty == false {
            self.projectList.removeAllObjects()
            for var i:Int = 0; i < allProjectList.count; i++ {
                let projectData:ProjectData = allProjectList.objectAtIndex(i) as! ProjectData
                if projectData.projectTitle.lowercaseString.rangeOfString(sender.text!.lowercaseString) != nil {
                    self.projectList.addObject(self.allProjectList.objectAtIndex(i))
                    
                }
                self.searchTableView.reloadData()
            }
        }
        else {
            self.projectList.removeAllObjects()
            for var i:Int = 0; i < allProjectList.count; i++ {
                self.projectList.addObject(allProjectList.objectAtIndex(i))
            }
            self.searchTableView.reloadData()
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell") as UITableViewCell!
        
        let projectData:ProjectData = projectList.objectAtIndex(indexPath.row) as! ProjectData
        let projectName:UILabel = cell.viewWithTag(1) as! UILabel
        projectName.text = projectData.projectTitle
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let projectData:ProjectData = projectList.objectAtIndex(indexPath.row) as! ProjectData
        GeneralUtil.setTeamId(String(projectData.id))
        let alertView = UIAlertView()
        alertView.title = "비밀번호 입력"
        alertView.addButtonWithTitle("Done")
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.textFieldAtIndex(0)?.placeholder = "비밀번호를 입력해주세요."
        alertView.addButtonWithTitle("Cancel")
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            let password:String = (alertView.textFieldAtIndex(0)?.text)!
            ServerUtil.enterProject(GeneralUtil.getTeamId() as String, password: password, reponseHandler: { (handler) -> Void in
                NSLog("handler = %@", handler)
                let result:Int = handler["result"] as! Int
                if result == 1 {
                    self.performSegueWithIdentifier("enterProjectSegue", sender: nil)
                }
            })
        }
    }
}
