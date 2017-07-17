//
//  LSubjectCell.swift
//  Healthy
//
//  Created by Liang on 17/4/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDWebImage

class LSubjectCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentTitle: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    var model: LHealthyTypeModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews()  {
//        self.contentImage.sd_setImage(with: URL.init(string: self.model.image!), placeholderImage: nil)
        self.contentTitle.text = self.model.Note
        self.typeLabel.text = self.model.FullName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.layer.cornerRadius = 5
//        self.bgView.layer.masksToBounds = true

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
