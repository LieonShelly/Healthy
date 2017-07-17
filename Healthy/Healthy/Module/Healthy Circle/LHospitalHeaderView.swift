//
//  LHospitalHeaderView.swift
//  Healthy
//
//  Created by Liang on 17/4/15.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LHospitalHeaderViewDelegate {
    func touchBack()
    func touchShare()
}

protocol LHospitalHeaderViewDataSource {
    func dataForViews() -> Any
}

class LHospitalHeaderView: UIView {

    @IBOutlet weak var hospitalImage: UIImageView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var hospitalIcon: UIImageView!
    @IBOutlet var hospitalEvaluate: [UILabel]!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalSubject: UILabel!
    
    var myDataSource: LHospitalHeaderViewDataSource! {
        didSet {
            self.reloadViews()
        }
    }
    
    var myDelegate: LHospitalHeaderViewDelegate!
    
    //刷新视图显示内容
    func reloadViews() {
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.hospitalIcon.layer.cornerRadius = 45
        self.hospitalIcon.layer.masksToBounds = true
        
        let effect = UIBlurEffect.init(style: .dark)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: screenWidth, height: 200))
        effectView.alpha = 0.6
        self.hospitalImage.addSubview(effectView)
        
        
        for label in self.hospitalEvaluate {
            label.layer.cornerRadius = 15
            label.layer.masksToBounds = true
            
        }
    }
    
    @IBAction func backToLast(_ sender: Any) {
        self.myDelegate.touchBack()
    }
    
    @IBAction func share(_ sender: UIButton) {
        self.myDelegate.touchShare()
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
