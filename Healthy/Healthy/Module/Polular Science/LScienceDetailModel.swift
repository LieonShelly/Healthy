//
//  LScienceDetailModel.swift
//  Healthy
//
//  Created by Liang on 17/7/3.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LScienceDetailModel: HandyJSON {
    var Colloff: String!
    var Data: String!
    var Data1: String!
    var DataType: String!
    var DoctorName: String!
    var FullName: String!
    var RowID: String!
    var SaveTime: String!
    var Url: String!

    
     required init() {
    }
    
    func mapping(mapper: HelpingMapper) {
        
    }
    
}
