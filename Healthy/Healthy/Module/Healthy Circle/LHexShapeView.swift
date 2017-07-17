//
//  LHexShapeView.swift
//  Healthy
//
//  Created by Liang on 17/6/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LHexShapeView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
//        let shapeMul = sqrt(3)
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: width / 2, y: 0))
        path.addLine(to: CGPoint.init(x: 0, y: height / 4))
        path.addLine(to: CGPoint.init(x: 0, y: height / 4 * 3))
        path.addLine(to: CGPoint.init(x: width / 2, y: height))
        path.addLine(to: CGPoint.init(x: width , y: height / 4 * 3))
        path.addLine(to: CGPoint.init(x: width, y: height / 4))
        path.addLine(to: CGPoint.init(x: width / 2, y: 0))
        path.close()
        
//        path.lineJoinStyle = .round
//        path.lineCapStyle = .round
        
//        path.lineWidth = 3
//        UIColor.red.setStroke()
        
        UIColor.green.setFill()
        path.fill()
        
        
//        path.stroke()
        
        /*
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = path.cgPath
//        shapeLayer.cornerRadius = width / 4
        
//        shapeLayer.backgroundColor = LColor.cgColor
//        shapeLayer.borderColor = UIColor.red.cgColor
//        shapeLayer.strokeColor = UIColor.white.cgColor
        /*
        let radom = arc4random() % 4
        switch radom {
        case 0:
            shapeLayer.fillColor = colorFromRGB(colorString: "#E56720").cgColor
            
        case 1:
            shapeLayer.fillColor = colorFromRGB(colorString: "#14C190").cgColor
        case 2:
            shapeLayer.fillColor = colorFromRGB(colorString: "#6A7179").cgColor
        case 3:
            shapeLayer.fillColor = colorFromRGB(colorString: "#EED499").cgColor
        default :
            break
        }
        */
        self.layer.addSublayer(shapeLayer)
//        self.layer.cornerRadius = width / 4
//        self.layer.masksToBounds = true
//        self.layer.mask = shapeLayer
        // Drawing code
 */
    }
    

}
