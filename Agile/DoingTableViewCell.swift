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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doingScrollView.delegate = self
        doingScrollView.contentSize = CGSizeMake(doingContentView.frame.size.width, 1)
        doingScrollView.alwaysBounceVertical=false
        doingScrollView.alwaysBounceHorizontal=false
        var tempFrame:CGRect = doingScrollView.frame
        tempFrame.origin.x = doingScrollView.frame.size.width
        doingScrollView.scrollRectToVisible(tempFrame, animated: false)
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
