//
//  LSpaceDetailSectionView.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LSpaceDetailSectionView: UIView {

    @IBOutlet weak var imageBGView: UIView!
    
    var model: Array<LSpaceCommentModel>! {
        didSet{
             self.reloadViews()
        }
    }
    
    
    
//    var images: Array<Any>! {
//        didSet {
//            
//        }
//    }
    
    func reloadViews() {
        let bgWidth = screenWidth - 50
        let maxCount = Int(bgWidth / 30)
        
        
        for i in 0 ..< model.count {
            
            if i < imageBGView.subviews.count{
                let view = imageBGView.subviews[i] as! UIButton
                view.sd_setBackgroundImage(with: URL.init(string: self.model[i].FImages), for: .normal)
//                view.setBackgroundImage(UIImage.init(named: ""), for: .normal)
            }
            else {
                let button = UIButton.init(frame: CGRect.init(x: 30 * model.count % maxCount, y: 34 * model.count / maxCount, width: 30, height: 30))
                button.tag = 100 + i
                button.addTarget(self, action: #selector(self.buttonClick(sender:)), for: .touchUpInside)
//                button.backgroundColor = LColor
                button.sd_setBackgroundImage(with: URL.init(string: self.model[i].FImages), for: .normal)

                self.imageBGView.addSubview(button)
            }
            
        }
        
        if imageBGView.subviews.count > model.count {
            for i in model.count ..< imageBGView.subviews.count {
                let view = imageBGView.subviews[i]
                view.removeFromSuperview()
            }
        }
    }
    
    func buttonClick(sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
