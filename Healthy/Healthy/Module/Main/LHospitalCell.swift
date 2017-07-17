//
//  LHospitalCell.swift
//  Healthy
//
//  Created by Liang on 17/4/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

protocol LHospitalCellDelegate {
    func headClick(sender: UIButton)
}

class LHospitalCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var detailIllness: UILabel!
    @IBOutlet weak var qustion: UILabel!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var headButton: UIButton!
    
    var myDelegate: LHospitalCellDelegate!
    
    var model: LHospitalModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews() {
        for i in 0 ..< 3 {
            let star = UIImageView.init(image: UIImage.init(named: "icon_collection"))
            star.frame = CGRect.init(x: 12 * i, y: 4, width: 12, height: 12)
            
            self.starView.addSubview(star)
        }
    }
    
    @IBAction func headClick(_ sender: UIButton) {
        if self.myDelegate != nil {
            self.myDelegate.headClick(sender: sender)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImage.layer.cornerRadius = 15
        self.headImage.layer.masksToBounds = true
        self.headImage.layer.borderColor = LColor.cgColor
        self.headImage.layer.borderWidth = 1.0
        
        self.doctorName.textColor = LColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
