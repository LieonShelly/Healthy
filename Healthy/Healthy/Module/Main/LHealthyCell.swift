//
//  LHealthyCell.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDWebImage

class LHealthyCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeDetailLabel: UILabel!
    
    var model:LHealthyTypeModel! {
        didSet {
            self.reloadView()
        }
    }
    
    func reloadView() {
//        self.typeImageView.sd_setImage(with: NSURL.init(string: (self.model?.image!)!) as URL?, placeholderImage: nil)
        self.typeNameLabel.text = self.model.FullName
        self.typeDetailLabel.text = self.model.Note
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
