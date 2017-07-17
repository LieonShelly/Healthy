//
//  LXMLModel.swift
//  Healthy
//
//  Created by Liang on 17/5/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import KissXML
import SystemConfiguration.CaptiveNetwork
//import xm
/*
<MessgaeData>
<Command>F000</Command>
<TableName>001</TableName>
<meType>0</meType>
<TableCom>9</TableCom>
 
<RemoteName>
 <TerminalData>
    <EquipmentNum>S0001</EquipmentNum>
    <Type>3</Type>
    <IP>192.168.1.1</IP>
    <MacData></MacData>
    <UserName>UF001</UserName>
    <Data>99910-11</Data>
 </TerminalData>
</RemoteName>
 
<LocalName>
 <TerminalData>
    <EquipmentNum>F0001</EquipmentNum>
    <Type>3</Type>
    <IP>192.168.1.1</IP>
    <MacData></MacData>
    <UserName>UF001</UserName>
    <Data>99910-99</Data>
 </TerminalData>
</LocalName>
 
<SaveTime>2015-09-09 16:18:23</SaveTime>
<Data>hehehehe</Data>
<Validation>5</Validation>
 
</MessgaeData>
*/

enum CommandType: String {
    case log = "F000"
    case opration = "F002"
    case regist = "F003"
}

class LXMLModel {
    
    static func initConnectXMLData(command: String, tableCom: String, tableName: String, dataStr: String) -> Data {
        
        let rootElement = DDXMLElement.init(name: "MessgaeData")
        
        let _ = createElement(name: "Command", value: command, superElement: rootElement)
        let _ = createElement(name: "TableName", value: tableName, superElement: rootElement)
        let _ = createElement(name: "meType", value: "0", superElement: rootElement)
        let _ = createElement(name: "TableCom", value: tableCom, superElement: rootElement)
        
        let remoteElement = createElement(name: "RemoteName", value: nil, superElement: rootElement)
        let terminalElement = createElement(name: "TerminalData", value: nil, superElement: remoteElement)
        let _ = createElement(name: "EquipmentNum", value: "C000001", superElement: terminalElement)
        let _ = createElement(name: "Type", value: "2", superElement: terminalElement)
        let _ = createElement(name: "IP", value: "39.108.106.9", superElement: terminalElement)
        let _ = createElement(name: "MacData", value: nil, superElement: terminalElement)
        let _ =  createElement(name: "UserName", value: "C000001", superElement: terminalElement)
        let _ = createElement(name: "Data", value: nil, superElement: terminalElement)
        
        
        let localElement = createElement(name: "LocalName", value: nil, superElement: rootElement)
        let lterminalElement = createElement(name: "TerminalData", value: nil, superElement: localElement)
        let _ = createElement(name: "EquipmentNum", value: "02:00:00:00:00:00", superElement: lterminalElement)
        let _ = createElement(name: "Type", value: "3", superElement: lterminalElement)
        let _ = createElement(name: "IP", value: nil, superElement: lterminalElement)
//        let _ = createElement(name: "MacData", value: self.getMacAddress(), superElement: lterminalElement)
        let _ = createElement(name: "MacData", value: "02:00:00:00:00:00", superElement: lterminalElement)
        let _ =  createElement(name: "UserName", value: "", superElement: lterminalElement)
        let _ = createElement(name: "Data", value: "1", superElement: lterminalElement)
       
        let _ = createElement(name: "SaveTime", value: self.getCurrentTime(), superElement: rootElement)
        let _ = createElement(name: "Data", value: dataStr, superElement: rootElement)
        let _ = createElement(name: "Validation", value: nil, superElement: rootElement)
//        let _ = createElement(name: "Command", value: "ssss", superElement: rootElement)
        var doc: DDXMLDocument = DDXMLDocument.init()
        do {
            print("成功")
            doc = try DDXMLDocument.init(xmlString: rootElement.xmlString, options: 0)
        } catch  {
            print("异常")
        }
        print(doc.xmlString)
        let data = doc.xmlData
//        let string = String.init(data: data, encoding: .utf8)
//        print(string)
        
        return data
    }
    
    static func createElement(name: String!, value: String!, superElement: DDXMLElement) -> DDXMLElement{
        let element = DDXMLElement.init(name: name, stringValue: value)
        superElement.addChild(element)
        
        return element
    }
    
    static func getCurrentTime() -> String{
        let date = Date.init(timeIntervalSinceNow: 0)
        let formater = DateFormatter.init()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let time = formater.string(from: date)
        
        return time
    }
    
    static func getMacAddress() -> String! {
        
        if let cfa: NSArray = CNCopySupportedInterfaces() {
            for x in cfa {
                if let dic = CFBridgingRetain(CNCopyCurrentNetworkInfo(x as! CFString)) {
                    let mac = dic["BSSID"]
                    return mac as! String!
                }
            }
        }
        
        return nil
        
    }
    
}
