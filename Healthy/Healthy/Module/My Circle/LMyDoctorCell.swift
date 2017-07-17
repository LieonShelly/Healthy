//
//  LMyDoctorCell.swift
//  Healthy
//
//  Created by Liang on 17/4/14.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LMyDoctorCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var hospital: UILabel!
    @IBOutlet weak var buyType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headImage.layer.cornerRadius = 20
        self.headImage.backgroundColor = LColor
        
        
        self.buyType.layer.borderColor = UIColor.orange.cgColor
        self.buyType.layer.borderWidth = 1.0
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
