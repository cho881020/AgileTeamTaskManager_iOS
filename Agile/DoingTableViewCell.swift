//
//  DoingTableViewCell.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 24..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class DoingTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var doingScrollView: UIScrollView!
    @IBOutlet weak var doingContentView: UIView!
    @IBOutlet weak var doingLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var widthRate:CGFloat!
    var heightRate:CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        widthRate = UIScreen.mainScreen().bounds.width / 375
        heightRate = UIScreen.mainScreen().bounds.height / 667
        
        doingScrollView.frame.size.width = 375 * widthRate
        doingScrollView.frame.size.height = 99 * heightRate
        
        doingContentView.frame.size.width = 1125 * widthRate
        doingContentView.frame.size.height = 99 * heightRate
        
        doingScrollView.delegate = self
        doingScrollView.contentSize = CGSizeMake(doingContentView.frame.size.width, 1)
        doingScrollView.alwaysBounceVertical=false
        doingScrollView.alwaysBounceHorizontal=false
        var tempFrame:CGRect = doingScrollView.frame
        tempFrame.origin.x = doingScrollView.frame.size.width
        doingScrollView.scrollRectToVisible(tempFrame, animated: false)

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
