//
//  LQustionHeaderView.swift
//  Healthy
//
//  Created by Liang on 17/4/26.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LQustionHeaderView: UIView {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var tapLabel: UIView!
    
    var model: LCircleHeaderModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews() {
        self.headImageView.image = UIImage.init(named: self.model.imageUrl)
        
        self.nameLabel.text = self.model.name
        self.gradeLabel.text = self.model.grade
        self.subjectLabel.text = self.model.subject
        
        for i in 0 ..< self.model.tapArray.count {
            let tapLabel = UILabel.init(frame: CGRect.init(x: (60 + 4) * i, y: 0, width: 60, height: 20))
            self.tapLabel.addSubview(tapLabel)
            
            tapLabel.textColor = UIColor.white
            tapLabel.backgroundColor = LColor
            tapLabel.font = UIFont.systemFont(ofSize: 12)
            tapLabel.text = self.model.tapArray[i]
            tapLabel.layer.cornerRadius = 2
            tapLabel.layer.masksToBounds = true
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
