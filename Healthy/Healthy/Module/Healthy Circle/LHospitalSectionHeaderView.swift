//
//  LHospitalSectionHeaderView.swift
//  Healthy
//
//  Created by Liang on 17/4/15.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LHospitalSectionHeaderViewDelegate {
    func loadMoreCase()
}

class LHospitalSectionHeaderView: UIView {

    var myDelegate: LHospitalSectionHeaderViewDelegate!
    
    @IBAction func loadMore(_ sender: UIButton) {
        self.myDelegate.loadMoreCase()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
