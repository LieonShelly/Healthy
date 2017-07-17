//
//  UserInfo.swift
//  Healthy
//
//  Created by Liang on 17/5/31.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation

class UserInfo  {
    
    static let share = UserInfo.init()
    
    private init() {
    }
    
    private let userDefault = UserDefaults.standard
    func getUserID() -> String! {
        return userDefault.object(forKey: "userID") as! String!
    }
    
    func setUserID(_ userID: String) {
        userDefault.set(userID, forKey: "userID")
    }
    
}
