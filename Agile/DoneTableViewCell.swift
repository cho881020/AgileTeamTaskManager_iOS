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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var deleteTaskBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doneScrollView.delegate = self
        doneScrollView.contentSize = CGSizeMake(doneContentView.frame.size.width, 1)
        doneScrollView.alwaysBounceVertical=false
        doneScrollView.alwaysBounceHorizontal=false
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
