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

//GCDAsyncUdpSocketDelegate
class LRequstXml: NSObject, GCDAsyncSocketDelegate  {
    
    typealias success = (Dictionary<String, Any>) -> ()
    typealias error = (String) -> ()

    var getData: success! = nil
    var requestError: error! = nil
    
    let host = "39.108.106.9"
    let port: UInt16 = 64501
    
    var socket: GCDAsyncSocket!
    
    static let share = LRequstXml.init()
    
    private override init() {
        super.init()
        self.initSocket()
    }
    
    func initSocket() {
        
        let mySocket = GCDAsyncSocket.init()
        mySocket.delegate = self
        mySocket.delegateQueue = DispatchQueue.main
        
        socket = mySocket
        
        do {
            try mySocket.connect(toHost: self.host, onPort: self.port, withTimeout: 3)
        }
        catch {
            print("connect error")
            if self.requestError != nil {
                self.requestError("连接失败")
            }
        }
        
    }
    
    func reConnect()  {
        
        do {
            try socket.connect(toHost: self.host, onPort: self.port)
            disConnect = false
        }
        catch {
            print("connect error")
            if self.requestError != nil {
                self.requestError("连接失败")
            }
            disConnect = true
        }
        
    }
    
     //业务数据
    func requestDataWith(tableName: String, dataStr: String) {
        self.requestDataWith(command: "F002", tableCom: "0", tableName: tableName, dataStr: dataStr)
    }
    
     //全部数据
    func requestDataWith(command: String, tableCom: String, tableName: String, dataStr: String) {
        
        if self.disConnect == true {
//            socket.disconnect()
            self.reConnect()
        }
        
        let data = LXMLModel.initConnectXMLData(command: command, tableCom: tableCom, tableName: tableName, dataStr: dataStr)
        let length = data.count
        
        print(length)
        var networkOrderVal = CFSwapInt32LittleToHost(UInt32(length))
        let theData =  Data.init(bytes: &networkOrderVal, count: MemoryLayout<UInt32>.size)
        
        socket.write(theData as Data, withTimeout: 10, tag: 0)
        socket.write(data, withTimeout: 10, tag: 0)
        
    }
    
    //MARK: - GCDAsyncSocketDelegate
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("连接成功")
        sock.readData(withTimeout: 8, tag: 0)
    }
    
    var disConnect: Bool = false
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        self.disConnect = true
        print("连接断开", err)
        if self.requestError != nil {
            self.requestError("连接断开")
        }
    }
    
    var lenth: Int = 0
    var addData: Data = Data.init()
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("收到数据", data)
        
        var tagData = data
        
        if lenth == 0{
            if data.count == 4 {
                let theData = NSData.init(data: data)
                theData.getBytes(&lenth, length: MemoryLayout<Int>.size)
                sock.readData(withTimeout: -1, tag: 0)
                return;
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
//            print("_______" , String.init(data: addData, encoding: .utf8))
            

            do {
                let newData = addData
                
                let doc = try DDXMLDocument.init(data: newData, options: 0)
//                print("_______" , String.init(data: doc.xmlData, encoding: .utf8))
                
                let docment: Array<DDXMLNode>
                do {
                    try docment = doc.nodes(forXPath: "//Data")
                    
                    for obj in docment {
                        let string = obj.stringValue!
                        if string == "失败" {
                            break;
                        }
                        
                        if !string.isEmpty {
                            let jsonData = string.data(using: .utf8)
                            let jsonDic = try?JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers)
                            if self.getData != nil {
                                sock.disconnect()
                                self.disConnect = true
                                
                                self.getData(jsonDic as! Dictionary)
                            }
                            print(jsonDic)
                            
                        }
                        print("222", string)
                    }
                    
                } catch  {
                    print("解析失败2")
                    if self.requestError != nil {
                        self.requestError("XML第二层解析失败")
                    }
                }
                
            } catch  {
                print("解析失败1")
                if self.requestError != nil {
                    self.requestError("XML第一层解析失败")
                }
                
            }
            //清空
            lenth = 0
            addData.removeAll()
        }
        else{
            sock.readData(withTimeout: -1, tag: 0)
        }
    }
    
    
}
