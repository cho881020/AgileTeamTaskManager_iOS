//
//  DoneTableViewCell.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 24..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class DoneTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var doneScrollView: UIScrollView!
    @IBOutlet weak var doneContentView: UIView!
    @IBOutlet weak var doneLabel: UILabel!

    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        widthRate = UIScreen.mainScreen().bounds.width / 375
        heightRate = UIScreen.mainScreen().bounds.height / 667
        
        doneScrollView.frame.size.width = 375 * widthRate
        doneScrollView.frame.size.height = 99 * heightRate
        
        doneContentView.frame.size.width = 750 * widthRate
        doneContentView.frame.size.height = 99 * heightRate
        
        doneScrollView.delegate = self
        doneScrollView.contentSize = CGSizeMake(doneContentView.frame.size.width, 1)
        doneScrollView.alwaysBounceVertical=false
        doneScrollView.alwaysBounceHorizontal=false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
