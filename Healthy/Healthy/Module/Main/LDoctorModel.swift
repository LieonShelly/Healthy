//
//  LDoctorModel.swift
//  Healthy
//
//  Created by Liang on 17/4/24.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LDoctorModel: HandyJSON{
    
    var id: String!
    var imageUrl: String!
    var name: String!
    var department: String!
    var grade: String!
    var hospitalName: String!
    var goodAt: [String]!
    var price: Int!
    
     var ClassID: String!
     var ClassName: String!
     var Data1: String!
     var DoctorName: String!
     var FullName: String!
     var GoodAt: String!
     var HospitalID: String!
     var HospitalName: String!
     var Images: String!
     var Money: String!
     var Money2: String!
     var Note: String!
     var Position: String!
     var RowID: String!
     var indexs: String!

    required init() {
        
    }
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &imageUrl, name: "avatar")
        
    }
}
