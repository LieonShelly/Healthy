//
//  LAllServiceCell.swift
//  Healthy
//
//  Created by Liang on 17/4/14.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDWebImage

class LAllServiceCell: UITableViewCell {

    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var qustionType: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var headIMage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var consType: UILabel!
    
    var model: LNowServiceModel! {
        didSet {
            self.loadViews()
        }
    }
    
    func loadViews()  {
        self.headIMage.sd_setImage(with: URL.init(string: self.model.imageUrl), placeholderImage: nil)
        self.name.text = self.model.username
        self.consType.text = self.model.type
        
        switch self.model.type {
        case "1":
            self.consType.text = ConsultType.picture.rawValue
        case "2":
            self.consType.text = ConsultType.voice.rawValue
        case "3":
            self.consType.text = ConsultType.analysis.rawValue
        default:
            self.consType.text = ""
        }
        
        self.dateAndTime.text = self.model.date + " 00:00"
        self.subject.text = self.model.department
        self.detail.text = self.model.excerpt
        if self.model.hasNewMsg == "1" {
            self.qustionType.text = "新问题"
        }
        else {
            self.qustionType.text = "旧问题"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headIMage.layer.cornerRadius = 12.5
        self.headIMage.backgroundColor = LColor
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
