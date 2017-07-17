//
//  LHospitalFooterView.swift
//  Healthy
//
//  Created by Liang on 17/4/15.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LHospitalFooterViewDelegate {
    func sendHeartToDoctor()
    func attentionDoctor()
    func consultationDoctor()
}

class LHospitalFooterView: UIView {

    var myDelegate: LHospitalFooterViewDelegate! 
    
    @IBOutlet weak var consultationbutton: UIButton!
    
    @IBAction func sendHeart(_ sender: UIButton) {
        self.myDelegate.sendHeartToDoctor()
    }
    
    @IBAction func attention(_ sender: UIButton) {
        self.myDelegate.attentionDoctor()
    }
    
    @IBAction func consultation(_ sender: UIButton) {
        self.myDelegate.consultationDoctor()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.consultationbutton.backgroundColor = LColor
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
