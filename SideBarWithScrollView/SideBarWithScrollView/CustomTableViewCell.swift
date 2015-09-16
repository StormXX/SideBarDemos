//
//  CustomTableViewCell.swift
//  SideBarWithScrollView
//
//  Created by DangGu on 15/9/15.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.masksToBounds = true
            avatarImageView.layer.cornerRadius = 3.0
        }
    }
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.imageView?.frame = CGRectMake(0, 0, 50, 50)
    }

}
