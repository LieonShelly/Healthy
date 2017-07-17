//
//  LSpaceScriptCell.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LSpaceScriptCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
   
    var model: LSpaceModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews()  {
        
        let formater = DateFormatter.init()
        formater.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = formater.date(from: model.SaveTime)
        let formater2 = DateFormatter.init()
        formater2.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let dateString = formater2.string(from: date!)
        
        
        let month = dateString.substring(with: (dateString.range(of: "年")?.upperBound)! ..< (dateString.range(of: "月")?.lowerBound)!)
        
        let day = dateString.substring(with: (dateString.range(of: "月")?.upperBound)! ..< (dateString.range(of: "日")?.lowerBound)!)
        
        let attriString = NSMutableAttributedString.init(string: String.init(format: "%02d%02d月",Int(day)!, Int(month)!))
        attriString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 19), range: NSMakeRange(0, 2))
        attriString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(2, 3))
        
        dateLabel.attributedText = attriString
 
        contentLabel.text = self.model.Note
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
