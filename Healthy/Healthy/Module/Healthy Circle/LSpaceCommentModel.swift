//
//  LSpaceCommentModel.swift
//  Healthy
//
//  Created by Liang on 17/6/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LSpaceCommentModel: HandyJSON {
    var Data1: String!
    var FImages: String!
    var FUserID: String!
    var FUserName: String!
    var HTType: String!//1是评论，0是点赞
    var RowID: String!
    var SaveTime: String!
    var TImages: String!
    var TUserID1: String!
    var TUserName: String!
    var TZID: String!
    
    required init() {
        
    }
     func mapping(mapper: HelpingMapper) {
        
    }
}
