//
//  LNavigationBar.swift
//  Healthy
//
//  Created by Liang on 17/4/12.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LNavigationBar: UIView {
    
    @IBOutlet weak var bgView: UIView!
    
    public lazy var leftButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        self.bgView.addSubview(button)
        
        print("left")
        return button
    }()
    
    public lazy var rightButton: UIButton = {
        print("show")
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: UIScreen.main.bounds.width - 44, y: 0, width: 44, height: 44)
        self.bgView.addSubview(button)
        
        return button
        
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: UIScreen.main.bounds.width / 2 - 50, y: 0, width: 100, height: 44))
        self.bgView.addSubview(label)
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        
        return label
    }()
    
//    lazy var name: String = "111"
    
    /*
    private var overLeftButton: UIButton!
    var leftButton: UIButton! {
        get {
            if overLeftButton == nil {
                overLeftButton = showLeftButton()
            }
            return overLeftButton
        }
    }
    
    private var overRightButton: UIButton!
    var rightButton: UIButton! {
        get {
//            print("right")
            if overRightButton == nil {
                overRightButton = showRightButton()
            }
            return overRightButton
        }
    }
    
    private var overTitleLabel: UILabel!
    var titleLabel: UILabel! {
        get {
            if overTitleLabel == nil {
                overTitleLabel = showTitleLabel()
            }
            return overTitleLabel
        }
    }
    
    
    private func showLeftButton() -> UIButton {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        self.bgView.addSubview(button)
        
        print("left")
        
        return button
    }
 
    private func showRightButton() -> UIButton {
       
    }
    
    private func showTitleLabel() -> UILabel {
        
    }
    
    override func awakeFromNib() {
        
    }
    */
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
