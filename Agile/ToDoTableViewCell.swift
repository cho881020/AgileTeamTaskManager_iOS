//
//  ToDoTableViewCell.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 21..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var toDoScrollView: UIScrollView!
    @IBOutlet weak var toDoContentView: UIView!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        widthRate = UIScreen.mainScreen().bounds.width / 375
        heightRate = UIScreen.mainScreen().bounds.height / 667
        
        toDoScrollView.frame.size.width = 375 * widthRate
        toDoScrollView.frame.size.height = 99 * heightRate
        
        toDoContentView.frame.size.width = 750 * widthRate
        toDoContentView.frame.size.height = 99 * heightRate
        
        toDoScrollView.delegate = self
        toDoScrollView.contentSize = CGSizeMake(toDoContentView.frame.size.width, 1)
        toDoScrollView.alwaysBounceVertical=false
        toDoScrollView.alwaysBounceHorizontal=false
        var tempFrame:CGRect = CGRectMake(0, 0, toDoScrollView.frame.width, toDoScrollView.frame.height)
        tempFrame.origin.x = toDoScrollView.frame.size.width
        toDoScrollView.scrollRectToVisible(tempFrame, animated: false)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
