//
//  LQuestionDetailCell.swift
//  Healthy
//
//  Created by Liang on 17/4/26.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LQuestionDetailCell: UITableViewCell {

    @IBOutlet weak var qipaoImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    var model: String!{
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews() {
        contentLabel.text = model
    }
    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        let totalHeight = self.contentLabel.sizeThatFits(size).height
//        return CGSize.init(width: size.width, height: totalHeight + 16)
//    }
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentLabel.preferredMaxLayoutWidth = 300 / 375 * screenWidth
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
