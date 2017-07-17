//
//  LScienceCellModel.swift
//  Healthy
//
//  Created by Liang on 17/4/6.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LScienceCellModel: HandyJSON {
    
    var date: String!
    var newsID: String!
    var newsUrl: String!
    var title: String!
    var excerpt: String!
    var type: String!
    var thumbnailUrl: String!
    var collectionsCount: String!
    var replyCount: String!
    
    var Data1: String!
    var Data2: String!
    var Data3: String!
    var FullName: String!
    var ImgePath: String!
    var Indexs: String!
    var Note: String!
    var PID: String!
    var RowID: String!
    var SaveTime: String!
//    var Note: String!
//    var type: String!
    
    required init() {
    }
    
     func mapping(mapper: HelpingMapper) {
        
    }
}
