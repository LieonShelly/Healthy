//
//  LPhotoToolbar.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LPhotoToolbarDelegate {
    func supportAction(sender: UIButton)
    func commentAction(sender: UIButton)
    func countAction(sender: UIButton)
}

class LPhotoToolbar: UIView {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var praiceCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    var myDelegate: LPhotoToolbarDelegate!
    
    
    @IBAction func praiceAction(_ sender: UIButton) {
        print("praiceAction")
        if self.myDelegate != nil {
            self.myDelegate.supportAction(sender: sender)
        }
    }
    @IBAction func commentClick(_ sender: UIButton) {
       print("commentClick")
        if self.myDelegate != nil {
            self.myDelegate.commentAction(sender: sender)
        }
    }
    
    @IBAction func countClick(_ sender: UIButton) {
       print("countClick")
        if self.myDelegate != nil {
            self.myDelegate.countAction(sender: sender)
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
