//
//  LDoctorCell.swift
//  Healthy
//
//  Created by Liang on 17/4/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDWebImage

protocol LDoctorCellDelegate {
    func headClick(cell:LDoctorCell, sende: UIButton)
}

class LDoctorCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var hospital: UILabel!
    @IBOutlet weak var skill: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var mydelegate: LDoctorCellDelegate!
    
    
    var model: LDoctorModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews()  {
        self.headImage.sd_setImage(with: URL.init(string: self.model.Images), placeholderImage: nil)
        self.name.text = self.model.DoctorName
        self.subject.text = self.model.ClassName
        self.rank.text = self.model.Position
        self.hospital.text = self.model.HospitalName
        self.price.text = "¥ \(self.model.Money!)元"
        
        self.skill.text = "擅长：" + self.model.GoodAt
//        var skills = "擅长："
//        for value in self.model.goodAt {
//            skills = skills + value + " "
//        }
//        self.skill.text = skills
        
        
    }
    
    @IBAction func headClick(_ sender: UIButton) {
        if self.mydelegate != nil {
            self.mydelegate.headClick(cell: self, sende: sender)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImage.layer.cornerRadius = 30
        self.headImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
