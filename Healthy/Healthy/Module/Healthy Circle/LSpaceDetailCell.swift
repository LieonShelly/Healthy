//
//  LSpaceDetailCell.swift
//  Healthy
//
//  Created by Liang on 17/6/6.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LSpaceDetailCell: UITableViewCell {

    @IBOutlet weak var headButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
   
    var model: LSpaceCommentModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews()  {
        self.headButton.sd_setBackgroundImage(with: URL.init(string: self.model.FImages), for: .normal)
//        self.headButton.setBackgroundImage(UIImage.init(named: self.model.FImages), for: .normal)
        self.contentLabel.text = self.model.Data1
        self.nameButton.setTitle(self.model.FUserName, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.nameButton.titleLabel?.textAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
