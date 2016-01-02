//
//  TeamSearchViewController.swift
//  Agile
//
//  Created by KJ Studio on 2016. 1. 2..
//  Copyright © 2016년 KJStudio. All rights reserved.
//

import UIKit

class TeamSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBAction func searchTeam(sender: UIButton) {
        NSLog("teamName = %@", searchTextField.text!)
        ServerUtil.searchTeam(searchTextField.text!) { (handler) -> Void in
            NSLog("handler = %@", handler)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell") as UITableViewCell!
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
