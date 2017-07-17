//
//  LUserCell.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LUserCell: UITableViewCell {

    @IBOutlet weak var optionImage: UIImageView!
    
    @IBOutlet weak var optionTitle: UILabel!
    
    @IBOutlet weak var optionDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.optionImage.layer.cornerRadius = 15
        self.optionImage.backgroundColor = LColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
