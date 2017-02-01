//
//  UserTableViewCell.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/31.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserSexLabel: UILabel!
    @IBOutlet weak var ViewDetailButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
