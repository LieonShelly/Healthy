//
//  LMyCircleCell.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDWebImage

enum ConsultType: String{
    case picture = "图文咨询"
    case voice = "语音咨询"
    case analysis = "健康分析"
}

class LMyCircleCell: UITableViewCell {

    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var consType: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var qustionType: UILabel!
    
    var model: LNowServiceModel! {
        didSet {
            self.loadViews()
        }
    }
    
    func loadViews()  {
        self.headImage.sd_setImage(with: URL.init(string: self.model.imageUrl), placeholderImage: nil)
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
        
        self.date.text = self.model.date
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
        self.headImage.layer.cornerRadius = 20
        self.headImage.backgroundColor = LColor
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
