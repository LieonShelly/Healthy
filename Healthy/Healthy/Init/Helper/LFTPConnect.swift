//
//  LFTPConnect.swift
//  Healthy
//
//  Created by Liang on 17/6/27.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import UIKit
import rebekka

class LFTPConnect {
    
//    let URLString = "home.lovcabin.com"
    let URLString = "118.113.203.47"
    let port = 9045
    let userName = "ftpiOS"
    let psw = "ftpiOS123"
  
    var mySession: Session!
    static let share = LFTPConnect.init()
    
    private init() {
        self.createConnect()
    }
    
    func createConnect()  {
        var config = SessionConfiguration()
//        ftp://
        config.host = "ftp://\(URLString):\(port)"
        config.username = userName
        config.password = psw
        
        mySession = Session.init(configuration: config)
    }
    
    func showList(path: String)  {
        
        mySession.list(path) { (resource, error) in
            
            print(resource, error)
//            for item in resource! {
//                print("文件类型：\(item.type)  文件名称： \(item.name)")
//            }
        }
    }
    
    func uploadImages(images: Array<UIImage>) {
        
        for image in images {
            let imageData = UIImageJPEGRepresentation(image, 0.6)
            let theURL = URL.init(dataRepresentation: imageData!, relativeTo: nil)
            let timeInterval = Date.init().timeIntervalSince1970
            
            let path = "/ios_\(timeInterval).png"
            
            mySession.upload(theURL!, path: path) { (result, error) in
                if result {
                    print("文件上传成功")
                } else {
                    print("文件上传失败 \(error)")
                }
            }
        }
    }
    
    
}

