//
//  LUserTypeView.swift
//  Healthy
//
//  Created by Liang on 17/4/13.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LUserTypeView: UIView {

    @IBOutlet private var typeView: [UIView]!
    
    @IBOutlet weak var residueMoney: UILabel!
    @IBOutlet weak var coupon: UILabel!
    @IBOutlet weak var gold: UILabel!
    @IBOutlet weak var badge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.badge.layer.cornerRadius = 4
        self.badge.layer.masksToBounds = true
        
        self.backgroundColor = LColor
        
        for view in typeView {
            
            view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.touchViews(recognizer:))))
            
        }
    }
    
    func touchViews(recognizer: UITapGestureRecognizer) {
        let index = recognizer.view!.tag - 100
        
        print(index)
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
