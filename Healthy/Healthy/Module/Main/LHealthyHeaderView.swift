//
//  LHealthyHeaderView.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LHealthyHeaderViewDelegate {
    func typeChanged(sender: UIButton)
}

class LHealthyHeaderView: UIView {

    var delegate: LHealthyHeaderViewDelegate!
    
    var modelArray: Array<LHealthyTypeModel>! {
        didSet {
            self.reloadView()
        }
    }
    
    //按钮下面的下划线
    private let typeLine = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 2))
    //标记上一个被选中的按钮
    private var lastButton: UIButton?
    
    func reloadView() {
        let count = self.modelArray.count
        
        for i in 0 ..< count {
            let model = self.modelArray[i]
            
            let buttonWidth = (UIScreen.main.bounds.width - 40) / CGFloat(count)
            
            let typeButton = UIButton.init(type: .custom)
            typeButton.frame = CGRect.init(x: CGFloat(20 + buttonWidth * CGFloat(i)), y: 5, width: buttonWidth, height: 30)
            self.addSubview(typeButton)
            
            typeButton.tag = 100 + i
            typeButton.setTitle(model.FullName, for: .normal)
            typeButton.setTitleColor(.black, for: .normal)
            typeButton.addTarget(self, action: #selector(self.changeType(sender:)), for: .touchUpInside)
            
            if i == 0 {
                self.addSubview(typeLine)
                typeLine.backgroundColor = LColor
                //设置下划线的位置
                self.typeLine.center = CGPoint.init(x: typeButton.frame.midX, y: typeButton.frame.maxY - 2)
                typeButton.setTitleColor(LColor, for: .normal)
                lastButton = typeButton
            }
        }
        self.bringSubview(toFront: typeLine)
    }
    
    
    func changeType(sender: UIButton) {
        if let button = lastButton {
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.typeLine.center = CGPoint.init(x: sender.frame.midX, y: sender.frame.maxY - 2)
            sender.setTitleColor(LColor, for: .normal)
        }, completion: nil)
        
        lastButton = sender
        //传入当前被点击的按钮
        self.delegate.typeChanged(sender: sender)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
