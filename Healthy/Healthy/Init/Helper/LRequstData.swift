//
//  LRequstData.swift
//  Healthy
//
//  Created by Liang on 17/4/24.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import UIKit

/*
func requestData(url: String, tableView: UITableView, inout &data: Array<Any>) {
    getRequest(route: "diseases?categories=1&page=0", parameters: nil) { (error, data) in
        //            print("data", data)
        
        if data != nil {
            //各种转换要死啊
            let dataDic = data! as? NSDictionary
            let dataArray = dataDic!.object(forKey: "data")!
            let theArray = dataArray as? Array<Any>
            
            for myArray in theArray! {
                if let theData = JSONDeserializer<LHealthyModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.myData.append(theData)
                    //                        print(theData.title, theData.detail)
                }
            }
            self.myTableView.reloadData()
        }
    }
}
 */
