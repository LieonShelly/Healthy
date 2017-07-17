//
//  LLoginInfo.swift
//  Healthy
//
//  Created by Liang on 17/7/13.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation

class LLoginInfo: NSObject, NSCoding {
    
    var userID: String! = nil
    var token: String! = nil;
    override init() {
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: "myToken")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.token = aDecoder.decodeObject(forKey: "myToken") as! String!
        
    }
    
}
