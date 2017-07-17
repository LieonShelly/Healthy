//
//  LFileManager.swift
//  Healthy
//
//  Created by Liang on 17/7/13.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation

class LFileManager {
    
    static let share = LFileManager.init()
    
    private init() {
    }
    
    func getToken() -> String! {
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: self.getLoginPath()) == false {
            return nil
        } else {
           let info = self.getLoginInfo()
            if info.token == nil {
                return nil
            } else {
                return info.token
            }
            
        }
        
    }
    
    func saveLoginInfo(info: LLoginInfo) {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(info, forKey: "login")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: self.getLoginPath(), atomically: true)
//        
//        let dictionary:NSDictionary = ["token": info.token, "userID": info.userID]
//        
//        let filePath: String = self.getLoginPath()
//        
//        dictionary.write(toFile: filePath, atomically: true)
    }
    
    func getLoginInfo() -> LLoginInfo {
        /*
        let manager = FileManager.default
//        let urlsForDocDirectory = manager.urls(for: .documentDirectory, in:.userDomainMask)
//        let docPath = urlsForDocDirectory[0]
//        let file = docPath.appendingPathComponent("test.txt")
        
        let file = URL.init(string: self.getLoginPath())
        
        //方法1
        let readHandler = try! FileHandle(forReadingFrom:file!)
        let data = readHandler.readDataToEndOfFile()
        let readString = String(data: data, encoding: String.Encoding.utf8)
        print("文件内容: \(readString)")
        
        //方法2
        let data2 = manager.contents(atPath: file!.path)
        let readString2 = String(data: data2!, encoding: String.Encoding.utf8)
        print("文件内容: \(readString2)")
        */
        
//        let data = NSMutableData.init(contentsOfFile: self.getLoginPath())
//        
//        let unArchiver = NSKeyedUnarchiver.init(forReadingWith: Data.init(referencing: data!))
//        
//        let archiveData = unArchiver.decodeObject(forKey: "login") as! LLoginInfo
//        unArchiver.finishDecoding()
//        
        
        //获取本地数据文件地址
        let path = self.getLoginPath()
        //读取文件数据
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        //解码器
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        //通过归档时设置的关键字Checklist还原lists
        let info = unarchiver.decodeObject(forKey: "login") as! LLoginInfo
        //结束解码
        unarchiver.finishDecoding()
            
        return info
        
    }

    func getLoginPath() -> String {
        let path = PWStorageManager.shareInstance().getModulePath(by: PWModuleTypeLogin)
        let filePath = path?.appending("/login.plist")
        
        return filePath!
    }
    
    
    
}
