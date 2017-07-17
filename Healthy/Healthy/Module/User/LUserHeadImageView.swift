//
//  LUserHeadImageView.swift
//  Healthy
//
//  Created by Liang on 17/4/13.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LUserHeadImageView: UIView {

    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dailyAttendance: UIButton!
    override func awakeFromNib() {
        self.headImage.layer.cornerRadius = 30
        self.headImage.layer.masksToBounds = true
        self.backgroundColor = LColor
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
