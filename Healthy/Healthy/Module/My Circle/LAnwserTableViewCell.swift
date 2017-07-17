//
//  LAnwserTableViewCell.swift
//  Healthy
//
//  Created by Liang on 17/6/1.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LAnwserTableViewCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var qipaoImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.headImage.layer.cornerRadius = 15
        self.headImage.layer.masksToBounds = true
        
        self.contentLabel.preferredMaxLayoutWidth = 300 / 375 * screenWidth
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
