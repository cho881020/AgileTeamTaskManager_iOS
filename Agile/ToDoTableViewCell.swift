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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        toDoScrollView.delegate = self
        toDoScrollView.contentSize = CGSizeMake(toDoContentView.frame.size.width, 1)
        toDoScrollView.alwaysBounceVertical=false
        toDoScrollView.alwaysBounceHorizontal=false
        var tempFrame:CGRect = toDoScrollView.frame
        tempFrame.origin.x = toDoScrollView.frame.size.width
        toDoScrollView.scrollRectToVisible(tempFrame, animated: false)
        
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
