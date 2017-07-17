//
//  LDoctoeDetailModel.swift
//  Healthy
//
//  Created by Liang on 17/4/24.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LDoctoeDetailModel:  HandyJSON{
    
    var id: String!
    var imageUrl: String!
    var name: String!
    var department: String!
    var grade: String!
    var hospitalName: String!
    var goodAtDesc: String!
    var medicalBackground: String!
    var academicResearchResult: String!
    var samplePlan: String!

    required init() { }
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &imageUrl, name: "images")
    }
    
    
}
