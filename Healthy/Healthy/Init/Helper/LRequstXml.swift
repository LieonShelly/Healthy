//
//  LRequstXml.swift
//  Healthy
//
//  Created by Liang on 17/5/27.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import CocoaAsyncSocket
import KissXML
import MBProgressHUD

class LRequstXml: NSObject {
    static let share = LRequstXml()
    var getData: (([String: Any]) -> Void)?
    var requestError: ((String) -> ())?
    fileprivate  let host = "39.108.106.9"
    fileprivate  let port: UInt16 = 64501
    fileprivate var socket = GCDAsyncSocket()
    fileprivate var lenth: Int = 0
    fileprivate var addData: Data = Data.init()
    fileprivate var disConnect: Bool = false
    
    private override init() {
        super.init()
        self.initSocket()
    }
    
   fileprivate func initSocket() {
        socket.delegate = self
        socket.delegateQueue = DispatchQueue.main
        do {
            try socket.connect(toHost: self.host, onPort: self.port, withTimeout: 3)
        }
        catch {
            print("connect error")
            if self.requestError != nil {
                self.requestError?("连接失败")
            }
        }
    }
    
    func reConnect()  {
        do {
            try socket.connect(toHost: host, onPort: port)
            disConnect = false
        }
        catch {
            requestError?("连接失败")
            disConnect = true
        }
        
    }
   
     // 全部数据
    func requestDataWith(command: String, tableCom: String, tableName: String, dataStr: String) {
        if disConnect {
             reConnect()
        }
        let data = LXMLModel.initConnectXMLData(command: command, tableCom: tableCom, tableName: tableName, dataStr: dataStr)
        let length = data.count
        var networkOrderVal = CFSwapInt32LittleToHost(UInt32(length))
        let theData =  Data.init(bytes: &networkOrderVal, count: MemoryLayout<UInt32>.size)
        socket.write(theData as Data, withTimeout: 10, tag: 0)
        socket.write(data, withTimeout: 10, tag: 0)
        
    }
    
}

extension LRequstXml: GCDAsyncSocketDelegate{
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接成功")
        sock.readData(withTimeout: 8, tag: 0)
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        self.disConnect = true
        print("连接断开", err.debugDescription)
        requestError?("连接断开")
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("收到数据", data)
        var tagData = data
        if lenth == 0 {
            if data.count == 4 {
                let theData = NSData.init(data: data)
                theData.getBytes(&lenth, length: MemoryLayout<Int>.size)
                sock.readData(withTimeout: -1, tag: 0)
                return
            }
            else {
                let newData = data.subdata(in: data.startIndex ..< data.index(data.startIndex, offsetBy: 4))
                let theData = NSData.init(data: newData)
                theData.getBytes(&lenth, length: MemoryLayout<Int>.size)
                
                tagData = data.subdata(in: data.index(data.startIndex, offsetBy: 4) ..< data.endIndex)
            }
            print("lenth" , lenth)
            print("data" , addData.count)
        }
        
        addData.append(tagData)
        if addData.count == lenth{
            print("*******Data Match: \(String(data: addData, encoding: .utf8) ?? "")")
            do {
                let newData = addData
                let doc = try DDXMLDocument.init(data: newData, options: 0)
                print("Response XML Data String:\( String(data: doc.xmlData, encoding: .utf8) ?? "")" )
                let docment: Array<DDXMLNode>
                do {
                    try docment = doc.nodes(forXPath: "//Data")
                    
                    for obj in docment {
                        guard let string = obj.stringValue else {   return  }
                        if string == "失败" {
                            break
                        }
                        if !string.isEmpty,  let jsonData = string.data(using: .utf8) {
                            let jsonDic = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            if self.getData != nil, let responseDic = jsonDic as? [String: Any] {
                                sock.disconnect()
                                disConnect = true
                                getData?(responseDic)
                                print("*********Response JSON: \(responseDic)")
                            }
                        }
                    }
                } catch  {
                    print("解析失败2")
                    if self.requestError != nil {
                        requestError?("XML第二层解析失败")
                    }
                }
                
            } catch  {
                print("解析失败1")
                if self.requestError != nil {
                    requestError?("XML第一层解析失败")
                }
                
            }
            lenth = 0
            addData.removeAll()
        }
        else{
            sock.readData(withTimeout: -1, tag: 0)
        }
    }
}
extension LRequstXml {
    /// 业务数据
    func requestDataWith(tableName: String, dataStr: String) {
        self.requestDataWith(command: "F002", tableCom: "0", tableName: tableName, dataStr: dataStr)
    }
}
