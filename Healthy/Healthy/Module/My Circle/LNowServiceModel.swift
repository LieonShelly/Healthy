//
//  LNowServiceModel.swift
//  Healthy
//
//  Created by Liang on 17/4/25.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LNowServiceModel: HandyJSON {
    
    var id: String!
    var chatId: String!
    var username: String!
    var type: String!
    var hasNewMsg: String!
//    var avatar: String!
    var date: String!
    var department: String!
    var excerpt: String!
    var imageUrl: String!
    
    required init() {
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &imageUrl, name: "avatar")

    }
}
