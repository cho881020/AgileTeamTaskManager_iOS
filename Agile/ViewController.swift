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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.dataSource = self
        toDoTableView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.superview?.isEqual(self.view) == true {
            NSLog("scrollViewDidScroll")
            var page:CGFloat!
            page = scrollView.contentOffset.x / scrollView.frame.size.width
            
            //setBarButtons(page)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = toDoTableView.dequeueReusableCellWithIdentifier("ToDoCell") as! ToDoTableViewCell
        
        let contentView = cell.toDoContentView as UIView
        let scrollView = cell.toDoScrollView as UIScrollView
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(contentView.frame.size.width, 1)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.alwaysBounceVertical=false
        scrollView.alwaysBounceHorizontal=false
        
        return cell
    }


}

