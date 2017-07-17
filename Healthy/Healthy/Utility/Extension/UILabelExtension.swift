//
//  UILabelExtension.swift
//  Healthy
//
//  Created by Liang on 17/6/1.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

//获取当前Label显示的字符串的长度
extension UILabel {
    func labelWidth() -> Double {
        
        var width: Double = 0.0
        let nsString: NSString = NSString.init(string: self.text!)
        let option: NSStringDrawingOptions = [NSStringDrawingOptions.usesFontLeading , NSStringDrawingOptions.usesLineFragmentOrigin]
        let boundsRect = nsString.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.size.width, height: 0), options: option, attributes: [NSFontAttributeName: self.font], context: nil)
        width = Double(boundsRect.size.width)
        
        return width
    }
    
    func labelHeight() -> Double {
        
//        CGRect rect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 85 * WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"ArialUnicodeMS" size:17.1]} context:nil];
//        
//        return rect.size.height;
        
        var width: Double = 0.0
        var height: Double = 0.0
        
        let nsString: NSString = NSString.init(string: self.text!)
        let option: NSStringDrawingOptions = [NSStringDrawingOptions.usesFontLeading , NSStringDrawingOptions.usesLineFragmentOrigin]
        let boundsRect = nsString.boundingRect(with: CGSize.init(width:UIScreen.main.bounds.size.width - 80 , height: 0), options: option, attributes: [NSFontAttributeName: self.font], context: nil)
//        width = Double(boundsRect.size.width)
        height = Double(boundsRect.size.height)

        return height
    }
}
