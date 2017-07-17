//
//  LScienceCell.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import SDWebImage

class LScienceCell: UITableViewCell {

    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentType: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    
    var cellIndexPath: IndexPath?
    var model: LScienceCellModel! {
        didSet {
            self.reloadView()
        }
    }
    
    func reloadView() {
//        let model = self.dataSource.cellViewData(indexPath: self.cellIndexPath!)
        
        contentType.text = model.FullName
        contentImage.sd_setImage(with: URL.init(string: model.ImgePath), placeholderImage: nil)
        contentTitle.text = model.Note
        dateLabel.text = model.date
        collectLabel.text = model.Data1 + "收藏"
        replyLabel.text = model.Data2 + "回复"
        
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
