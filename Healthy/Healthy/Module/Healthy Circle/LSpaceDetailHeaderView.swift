//
//  LSpaceDetailHeaderView.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LSpaceDetailHeaderView: UIView {

    @IBOutlet weak var headButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageBG: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
   
    var model: LSpaceModel! {
        didSet {
            self.reloadViews()
        }
    }
    
    func reloadViews()  {
//        UIImage.init(data: <#T##Data#>)
        self.headButton.imageView?.image = UIImage.init(named: "healthy_main")
//        self.headButton.setBackgroundImage(UIImage.init(named: ""), for: .normal)
//        self.nameButton.setTitle(model.DoctorName, for: .normal)
        self.contentLabel.text = model.Note
        self.dateLabel.text = model.SaveTime
        
        self.initContentImage(model.imagePath_thum)
    }
    
    
    func initContentImage(_ imageArray: Array<String>) {
        
        for view in contentImageBG.subviews {
            view.removeFromSuperview()
        }
        
        if imageArray.count == 2 {
            let theImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 128))
            theImageView.sd_setImage(with: URL.init(string: imageArray[0]), placeholderImage: UIImage.init(named: "healthy_main"))
            theImageView.contentMode = .scaleAspectFit
            contentImageBG.addSubview(theImageView)
            
        } else if imageArray.count == 3 {
            for i in 0 ..< 2 {
                let theImageView = UIImageView.init(frame: CGRect.init(x: 80 * i, y: 0, width: 80, height: 120))
                theImageView.sd_setImage(with: URL.init(string: imageArray[i]), placeholderImage: UIImage.init(named: "healthy_main"))
                contentImageBG.addSubview(theImageView)
                
            }
        } else {
            for i in 0 ..< 4 {
                if i >= imageArray.count {
                    break;
                }
                
                let theImageView = UIImageView.init(frame: CGRect.init(x: 60 * (i % 2), y: 60 * (i / 2), width: 60, height: 60))
                theImageView.sd_setImage(with: URL.init(string: imageArray[i]), placeholderImage: UIImage.init(named: "healthy_main"))
                contentImageBG.addSubview(theImageView)
            }
        }
    }

    
    @IBAction func headClick(_ sender: UIButton) {
    }
    @IBAction func nameClick(_ sender: UIButton) {
    }
    @IBAction func deleteCilick(_ sender: UIButton) {
    }
    @IBAction func commentClick(_ sender: UIButton) {
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
