//
//  LCircleTypeView.swift
//  Healthy
//
//  Created by Liang on 17/4/13.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LCircleTypeViewDelegate {
    func typeChanged(_ index: Int)
}

class LCircleTypeView: UIView {
    
    var myDelegate: LCircleTypeViewDelegate!
    
    
    var lastButton: UIButton!
    
    @IBOutlet private weak var serviceNow: UIButton!
    @IBOutlet weak var line: UIView!
    @IBAction func changeType(_ sender: UIButton) {
        if lastButton.tag != sender.tag {
            lastButton.setTitleColor(UIColor.black, for: .normal)
            sender.setTitleColor(LColor, for: .normal)
            self.line.frame = CGRect.init(origin: CGPoint.init(x: sender.frame.minX, y: 39), size: size)
            lastButton = sender
        }
        self.myDelegate.typeChanged(sender.tag - 100)
    }
    
   private let size = CGSize.init(width: screenWidth / 3, height: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lastButton = serviceNow
        
        self.serviceNow.setTitleColor(LColor, for: .normal)
        self.line.backgroundColor = LColor
        self.line.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 39), size: size)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
