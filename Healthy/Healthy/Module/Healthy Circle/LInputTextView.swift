//
//  LInputTextView.swift
//  Healthy
//
//  Created by Liang on 17/6/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LInputTextViewdelegate {
    
}

class LInputTextView: UIView, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    
    @IBAction func sendButtonClick(_ sender: UIButton) {
    
    }
    
    @IBAction func emojiButtonClick(_ sender: UIButton) {
    
    }
    
    @IBAction func textfieldDidChanged(_ sender: UITextField) {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
