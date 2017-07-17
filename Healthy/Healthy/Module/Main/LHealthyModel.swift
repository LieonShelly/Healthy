//
//  LHealthyModel.swift
//  Healthy
//
//  Created by Liang on 17/4/12.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LHealthyModel: HandyJSON{
    var image: String?
    var title: String?
    var detail: String?
    var id: String?
    var myid: String?
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        
        mapper.specify(property: &image, name: "images")
        mapper.specify(property: &detail, name: "description")
        
    }
    
}
