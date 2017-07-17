//
//  LMyCircleHeaderView.swift
//  Healthy
//
//  Created by Liang on 17/4/14.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit



class LMyCircleHeaderView: UIView {

    @IBOutlet weak var searchDoctor: UIButton!
    @IBOutlet weak var headImage: UIImageView!
    @IBAction func searchDoctoe(_ sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headImage.layer.cornerRadius = 20
        self.headImage.layer.masksToBounds = true
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
