//
//  LSpaceImageCell.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LSpaceImageCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentImageBG: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageCountLabel: UILabel!
   
    
    var model: LSpaceModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews()  {
//        print("从c到f的字符串:\(theVariableString.substring(with: (theVariableString.range(of: "c")?.lowerBound)! ..< (theVariableString.range(of: "f")?.upperBound)!))")
        
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
        contentLabel.text = model.Note
        imageCountLabel.text = "共\(model.imagePath_thum.count - 1)张"
        self.initContentImage(model.imagePath_thum)
    }
    
    func initContentImage(_ imageArray: Array<String>) {
        
        for view in contentImageBG.subviews {
            view.removeFromSuperview()
        }
        
        if imageArray.count == 2 {
            let theImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 80))
            theImageView.sd_setImage(with: URL.init(string: imageArray[0]), placeholderImage: UIImage.init(named: "healthy_main"))
            contentImageBG.addSubview(theImageView)
            
        } else if imageArray.count == 3 {
            for i in 0 ..< 2 {
                let theImageView = UIImageView.init(frame: CGRect.init(x: 40 * i, y: 0, width: 40, height: 80))
                theImageView.sd_setImage(with: URL.init(string: imageArray[i]), placeholderImage: UIImage.init(named: "healthy_main"))
                contentImageBG.addSubview(theImageView)
                
            }
        } else {
            for i in 0 ..< 4 {
                if i >= imageArray.count {
                    break;
                }
                
                let theImageView = UIImageView.init(frame: CGRect.init(x: 40 * (i % 2), y: 40 * (i / 2), width: 40, height: 40))
                theImageView.sd_setImage(with: URL.init(string: imageArray[i]), placeholderImage: UIImage.init(named: "healthy_main"))
                contentImageBG.addSubview(theImageView)
            }
        }
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
