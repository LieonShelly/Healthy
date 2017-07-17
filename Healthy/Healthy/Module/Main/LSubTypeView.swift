//
//  LSubTypeView.swift
//  
//
//  Created by Liang on 17/4/12.
//
//

import UIKit

protocol LSubTypeViewDelegate {
    func changeType(_ sender: UIButton)
    func sortData(_ sender: UIButton)
}

class LSubTypeView: UIView {

    @IBOutlet weak var subTypeButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    var delegate: LSubTypeViewDelegate!
    
    
    @IBAction func changeType(_ sender: UIButton) {
        self.delegate.changeType(sender)
    }
    
    @IBAction func sortData(_ sender: UIButton) {
        self.delegate.sortData(sender)
        
    }
    
    override func awakeFromNib() {
        
        
        
        
//        self.subTypeButton.imageEdgeInsets = UIEdgeInsets.init(top: 4, left: CGFloat(width), bottom: 4, right: 0)
        //为了保持箭头位置好看 必须加一个空格
//        self.subTypeButton.setTitle("全部科室" + " ", for: .normal)
//        let width = self.subTypeButton.titleLabel!.labelWidth()
//        //设置箭头的位置和大小
//        self.subTypeButton.imageEdgeInsets = UIEdgeInsets.init(top: 4, left: CGFloat(width), bottom: 4, right: 0)
//        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
