//
//  Helper.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import UIKit


/**
 *  从16进制（字母大写）转换成十进制
 *
 *  @return 十进制整数
 */
private func intFromHex(hex: String) -> Int {
    var hex = hex
    var sum = 0
    hex = hex.uppercased()
    for scalar in hex.unicodeScalars {
        let asciiValue = Int(scalar.value)
        let n: Int = asciiValue >= 65 ? asciiValue - 55 : asciiValue - 48
        sum = sum * 16 + n
    }
    return sum
}

//返回RGB颜色
func colorFromRGBA(colorString: String, alpha: Float) -> UIColor {
    var colorLiteral = colorString
    
    var red, green, blue: Int
    red = intFromHex(hex: String(colorLiteral.characters.dropFirst().prefix(2)))
    green = intFromHex(hex: String(colorLiteral.characters.dropFirst(3).prefix(2)))
    blue = intFromHex(hex: String(colorLiteral.characters.dropFirst(5).prefix(2)))
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
}

func colorFromRGB(colorString: String) -> UIColor {
    return colorFromRGBA(colorString: colorString, alpha: 1)
}


let LColor = UIColor.init(red: 23 / 255.0, green: 187 / 255.0, blue: 153 / 255.0, alpha: 1)

//屏幕尺寸
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let screenSize = UIScreen.main.bounds.size

//导航栏离顶端距离
let topSpace = 0




