//
//  LWXPay.swift
//  Healthy
//
//  Created by Liang on 17/7/6.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import Alamofire
import KissXML
//import ifa

// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
let WX_APPID = "wxcc3c5a4360af8ac2"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
let WX_APPSecret = "81ed3ea3bb75e67531b2d9c5a19baa47"
// 微信支付商户号
let MCH_ID = "1470716602"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
let WX_PartnerKey = "dodfg0147258369jkdjkkdkdkjdssdfs"


//MARK: - 统一下单请求参数键值

//  应用id
let WXAPPID = "appid"
//  商户号
let WXMCHID = "mch_id"
//  随机字符串
let WXNONCESTR = "nonce_str"
//  签名
let WXSIGN = "sign"
//  商品描述
let WXBODY = "body"
//  商户订单号
let WXOUTTRADENO = "out_trade_no"
//  总金额
let WXTOTALFEE = "total_fee"
//  终端IP
let WXEQUIPMENTIP = "spbill_create_ip"
//  通知地址
let WXNOTIFYURL = "notify_url"
//  交易类型
let WXTRADETYPE = "trade_type"
//  预支付交易会话
let WXPREPAYID = "prepay_id"

//MARK: - 微信下单接口

//  微信统一下单接口连接
let WXUNIFIEDORDERURL = "https://api.mch.weixin.qq.com/pay/unifiedorder"


class LWXPay {
    
    func startWXPay() {
        
       /*
        Alamofire.upload(self.initConnectXML().data(using: .utf8)!, to: WXUNIFIEDORDERURL).responseData { (response) in
            
            
        }
        */
        
//        Alamofire.upload(self.initConnectXML().data(using: .utf8)!, to: WXUNIFIEDORDERURL, method: .post, headers: nil).responseData { (response) in
//            
//        }
        
        /*
        Alamofire.request(WXUNIFIEDORDERURL, method: .post, parameters: ["pam": initConnectXML()], encoding: PropertyListEncoding.xml).responsePropertyList { (response: DataResponse<Any>) in
            
        }
        responseJSON{ (response:DataResponse<Any>) in
            
            switch response.result {
            case .success(let data):
                print("sucsess:\(data)")
            case .failure:
                print(":请求发生异常")
            }
        }*/
        
    }
    
    /*
    func wxPar(totoal_fee: String, body: String) {
        
        if !WXApi.isWXAppInstalled() {
            print("没有安装微信"); return
        }else if !WXApi.isWXAppSupport() {
            print("当前版本不支持微信支付"); return
        }
        
        /*
        let timeIntravel = UInt64(NSDate().timeIntervalSince1970 * 100000)
        let ran = arc4random() % 99999;
        
        var parameters = [String: Any]()
        parameters["appid"] = WX_APPID
        parameters["mch_id"] = MCH_ID
        parameters["nonce_str"] = "\(timeIntravel)"
//        parameters["body"] = body
        parameters["out_trade_no"] = "\(ran)"
        parameters["total_fee"] = 1
        parameters["spbill_create_ip"] = LiPhoneData.getIPAddress(true)
        parameters["notify_url"] = "http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
        parameters["trade_type"] = "APP"
        
        // MARK: - Sign & XML
        
        var stringA = String(), XMLString = "\n<xml>";
        
        for key in parameters.keys.sort() {
            stringA.appendContentsOf("\(key)=\(parameters[key]!)&")
            XMLString.appendContentsOf("\n\t<\(key)>\(parameters[key]!)</\(key)>")
        }
        stringA.removeAtIndex(stringA.endIndex.predecessor())
        
        let sign = WXParameters.md5("\(stringA)&key=\(api_key)").uppercaseString
        XMLString.appendContentsOf("\n\t<sign>\(sign)</sign>\n</xml>")
        */
        
        // MARK: - END
        
        Alamofire.upload(.post, "https://api.mch.weixin.qq.com/pay/unifiedorder", data: self.initConnectXML().data(using: .utf8)).responseData { (response) in
            
            switch response.result {
            case .Success(let data):
                
                let prepay_id = try! ONOXMLDocument.init(data: data).rootElement.firstChildWithTag("prepay_id").stringValue()
                
                let request = PayReq.init()
                request.nonceStr = WXParameters.nonce_str()
                request.package = "Sign=WXPay"
                request.partnerId = self.mch_id
                request.prepayId = prepay_id
                request.timeStamp = UInt32(NSDate.init().timeIntervalSince1970)
                
                let stringA = "appid=\(self.app_id)&noncestr=\(request.nonceStr)&package=Sign=WXPay&partnerid=\(self.mch_id)&prepayid=\(prepay_id)&timestamp=\(request.timeStamp)"
                
                request.sign = WXParameters.md5("\(stringA)&key=\(self.api_key)").uppercaseString
                
                WXApi.sendReq(request)
                
            case .Failure(let error):
                print("统一下单失败！\(error)")
            }
        }
    }*/
        
        /*
    func initConnectXML() -> String {
        
        let rootElement = DDXMLElement.init(name: "xml")
        
        let _ = createElement(name: "appid", value: WX_APPID, superElement: rootElement)
        let _ = createElement(name: "attach", value: "支付测试", superElement: rootElement)
        let _ = createElement(name: "mch_id", value: MCH_ID, superElement: rootElement)
        let timeIntravel = UInt64(NSDate().timeIntervalSince1970)
        let ran = arc4random() % 99999;
        
        let _ = createElement(name: "nonce_str", value: "\(timeIntravel)abc\(ran)", superElement: rootElement)
        let _ = createElement(name: "notify_url", value: "http://wxpay.wxutil.com/pub_v2/pay/notify.v2.php", superElement: rootElement)
        
        let _ = createElement(name: "out_trade_no", value: "\(timeIntravel)", superElement: rootElement)
        
        let _ = createElement(name: "spbill_create_ip", value: LiPhoneData().getIPAddress(true), superElement: rootElement)
        
        let _ = createElement(name: "total_fee", value: "1", superElement: rootElement)
        
        let _ = createElement(name: "trade_type", value: "APP", superElement: rootElement)
        let _ = createElement(name: "sign", value: WX_PartnerKey, superElement: rootElement)
        
        
        var doc: DDXMLDocument = DDXMLDocument.init()
        do {
            print("成功")
            doc = try DDXMLDocument.init(xmlString: rootElement.xmlString, options: 0)
        } catch  {
            print("异常")
        }
        print(doc.xmlString)

        return doc.xmlString
    }
    */
    
    func createElement(name: String!, value: String!, superElement: DDXMLElement) -> DDXMLElement{
        let element = DDXMLElement.init(name: name, stringValue: value)
        superElement.addChild(element)
        
        return element
    }
    
    
}
