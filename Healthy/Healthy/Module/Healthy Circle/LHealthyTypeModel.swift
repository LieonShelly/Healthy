//
//  LHealthyTypeModel.swift
//  Healthy
//
//  Created by Liang on 17/5/31.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LHealthyTypeModel: HandyJSON {
    var DataType: String!
    var Deleted: String!
    var FullName: String!
    var ImgePath: String!
    var Indexs: String!
    var Levels: String!
    var Note: String!
    var PID: String!
    var RowID: String!
    var SaveTime: String!
    
    var dataArray: Array<LHealthyTypeModel> = []
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        
    }
}
