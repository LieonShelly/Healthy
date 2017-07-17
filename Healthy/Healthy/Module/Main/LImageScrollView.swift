//
//  LImageScrollView.swift
//  Healthy
//
//  Created by Liang on 17/4/12.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDCycleScrollView

protocol LImageScrollViewDataSource {
    func images() -> [Any]
    //如不需要  请传空
    func titles() -> [String]?
}

class LImageScrollView: SDCycleScrollView {

    var myDataSource: LImageScrollViewDataSource! {
        didSet {
         self.reloaView()
        }
    }
    
    func reloaView() {
        
        let images = self.myDataSource.images()
        let image = images[0]
        
        
        if image is String {
            self.imageURLStringsGroup = images
        } else {
            if image is UIImage {
                self.titleLabelBackgroundColor = UIColor.clear
                self.localizationImageNamesGroup = images
            }
            else {
                print("传入数据,格式不正确")
            }
        }
        
        if let titles = self.myDataSource.titles() {
            self.titlesGroup = titles
        }
        
        //不允许自动滚动
        self.autoScroll = false
        //允许无限循环
        self.infiniteLoop = true
        
        //不显示分页控件
        self.showPageControl = false
    }
    
    override func awakeFromNib() {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
