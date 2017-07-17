//
//  LScienceTypeModel.swift
//  Healthy
//
//  Created by Liang on 17/4/25.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LScienceTypeModel: HandyJSON{
    
    var FullName: String!
    var ImgePath: String!
    var Indexs: String!
    var RowID: String!
    var SaveTime: String!
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        
    }
}
