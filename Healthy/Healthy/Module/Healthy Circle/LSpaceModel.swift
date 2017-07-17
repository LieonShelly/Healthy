//
//  LSpaceModel.swift
//  Healthy
//
//  Created by Liang on 17/6/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import HandyJSON

class LSpaceModel: HandyJSON {
    
    var Data1: String!
    var Data2: String!
    var Data3: String!
    var FullName: String!
    var ImgePath: String!
    var Note: String!
    var RowID: String! 
    var SaveTime: String!
    var WImgePath: String!
    
    var imagePath_thum: Array<String>!
    var imagePath: Array<String>!

    
    required init() { }
    
    func mapping(mapper: HelpingMapper) {
//        mapper.specify(property: &imageUrl, name: "images")
        mapper.specify(property: &imagePath_thum, name: "WImgePath") { (string) -> Array<String>! in
            let imageurl: NSString = NSString.init(string: string)
            let stringArray = imageurl.components(separatedBy: ";")
            return stringArray
        }
        
        mapper.specify(property: &imagePath, name: "ImgePath") { (string) -> Array<String>! in
            let imageurl: NSString = NSString.init(string: string)
            let stringArray = imageurl.components(separatedBy: ";")
            
            return stringArray
        }
        
    }
}
