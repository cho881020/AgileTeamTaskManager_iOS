//
//  AddToDoViewController.swift
//  Agile
//
//  Created by KJ Studio on 2016. 1. 6..
//  Copyright © 2016년 KJStudio. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet weak var workerBtn: UIButton!
    @IBOutlet weak var toDoContent: UITextField!
    
    @IBAction func addToDoBtn(sender: UIButton) {
        ServerUtil.newTask(GeneralUtil.getUserId() as String, userTask: toDoContent.text, projectId: GeneralUtil.getTeamId() as String) { (handler) -> Void in
            NSLog("handler = %@", handler)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func workerSelectBtn(sender: UIButton) {
    }
    
    @IBAction func endEdit(sender: UIButton) {
        toDoContent.resignFirstResponder()
    }
    @IBAction func dismissKeyborad(sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
