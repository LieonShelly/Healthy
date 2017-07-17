//
//  LHTTPHelper.swift
//  Healthy
//
//  Created by Liang on 17/4/24.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import HandyJSON


enum ErrorType:Error {
    case Normal
    case Illegal //非法调用
    case NetNotReachable//网络问题
    
    var description:String {
        switch self {
        case .Illegal:
            return "非法操作"
        case .Normal :
            return "正常"
        case .NetNotReachable:
            return "网络连接异常"
        }
    }
}

typealias RequestBlock = (ErrorType ,Any?)->Void
typealias RequestDataBlock = (Data?)->Void
typealias RequestProgressBlock = (Progress) -> Void

private let httpBaseUrl:String = {
    return "http://hs.w1.oyfei.cn:8102/api/v1/"
    }()

private let networkManager:NetworkReachabilityManager = {
    return NetworkReachabilityManager(host: "www.baidu.com")!
}()

func checkNetworkStatus() {
    networkManager.listener = {
        status in
        switch status {
        case .notReachable:
            // 网络不可达到
            print("网络不可达")
//            log.debug("网络不可达")
        case .unknown:
            //未知网络错误
            print("未知错误")
//            log.debug("未知错误")
        case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
            print("")
//            log.debug("")
        case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
            print("wifi")
//            log.debug("wifi")
        }
    }
}

func requestNetCheck() ->(Bool) {
    return networkManager.isReachable
}


func getRequest(route:String, completion:@escaping RequestBlock) {
    
    if !requestNetCheck() {
        completion(.NetNotReachable, nil)
        return
    }
    
    let url = httpBaseUrl + route
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
        switch response.result {
        case .success(let data):
            print(url, data)
            //            log.info(url)
            //            log.info(data)
            completion(.Normal, data)
        case .failure:
            print(":请求发生异常")
            //            log.error(url+":请求发生异常")
            //                    completion(.Illegal, data)
        }
    }
}

func getRequest(route:String,parameters:[String:Any]?, completion:@escaping RequestBlock) {
//    log.info(route)
//    log.info(parameters)
    
    if !requestNetCheck() {
        completion(.NetNotReachable, nil)
        return
    }
    
    let url = httpBaseUrl + route
    print("url", url)
    Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
        switch response.result {
        case .success(let data):
//            print(url, data)
//            log.info(url)
//            log.info(data)
                    completion(.Normal, data)
        case .failure:
            print(":请求发生异常")
//            log.error(url+":请求发生异常")
//                    completion(.Illegal, data)
        }
    }
}

func postRequest(route:String,parameters:[String:Any]?, completion:@escaping RequestBlock) {
    if !requestNetCheck() {
        completion(.NetNotReachable, nil)
        return
    }
    
    let url = httpBaseUrl + route
     Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
        switch response.result {
        case .success(let data):
            print(url, data)
            //            log.info(url)
            //            log.info(data)
                completion(.Normal, data)
        case .failure:
            print(":请求发生异常")
            //            log.error(url+":请求发生异常")
//                completion(.Illegal, data)
        }
    }
//    Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: <#T##HTTPHeaders?#>)
    
}

func putRequest(route:String,parameters:[String:Any]?, completion:RequestBlock) {
//    log.info(route)
//    log.info(parameters)
    if !requestNetCheck() {
        completion(.NetNotReachable, nil)
        return
    }
    let url = httpBaseUrl + route
    Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
        switch response.result {
        case .success(let data):
//            log.info(url)
//            log.info(data)
            print(url, data)
        case .failure:
            
            print(":请求发生异常")
//            log.error(url+":请求发生异常")
        }
    }
}

func deleteRequest(route:String,parameters:[String:Any]?, completion:RequestBlock) {
//    log.info(route)
//    log.info(parameters)
    if !requestNetCheck() {
        completion(.NetNotReachable, nil)
        return
    }
    let url = httpBaseUrl + route
    Alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response:DataResponse<Any>) in
        switch response.result {
        case .success(let data):
            print(url, data)
//            log.info(url)
//            log.info(data)
        case .failure:
            print(":请求发生异常")
//            log.error(url+":请求发生异常")
        }
    }
}

func downloadFileRequest(route:String,fileUrl:URL,progressHandler:@escaping RequestProgressBlock,completion:RequestDataBlock) {
//    log.info(route)
//    log.info(fileUrl)
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
    }
    let url = httpBaseUrl + route
    let fileManager = FileManager.default
    //如果这个东西存在
    var resumeData:Data? = nil
    if fileManager.fileExists(atPath: fileUrl.path) {
        resumeData = fileManager.contents(atPath: fileUrl.path)
    }
    let request:DownloadRequest
    if resumeData == nil {
        //重新下载
        request = Alamofire.download(url, to: destination)
    }else {
        request = Alamofire.download(resumingWith: resumeData!)
    }
    request.downloadProgress(closure: progressHandler)
    
    request.responseData { (response) in
        switch response.result {
        case .success(let data):
            print(data)
        case .failure:
            print(":请求发生异常")
//            log.error(url+":请求发生异常")
        }
    }
}

func uploadFileRequest(route:String,data:Data,progressHandler:@escaping RequestProgressBlock) {
//    log.info(route)
    let url = httpBaseUrl + route
    let request = Alamofire.upload(data, to: url)
    request.uploadProgress(closure: progressHandler)
    request.responseJSON { response in
        switch response.result {
        case .success(let data):
            print(data)
        case .failure:
            print(":请求发生异常")
//            log.error(url+":请求发生异常")
        }
    }
}

class HttpHelper: NSObject {
    // TODO:singleton
    struct Inner {
        static let instance = HttpHelper()
    }
    
    class var shared: HttpHelper {
        return Inner.instance
    }
    
}

extension HttpHelper {
    
    /// Get方法请求Http数据
    ///
    /// - Parameters:
    ///   - urlString: 请求路径
    ///   - params: 请求参数
    ///   - success: 请求成功执行程序
    ///   - failture: 请求失败执行程序
    func get(urlString: String, params: [String: Any], success: @escaping (_ response: [String: AnyObject])->(), failure: @escaping (_ error: Error)->()) {
        Alamofire.request("\(httpBaseUrl)\(urlString)", method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    debugPrint("succ get \(urlString), params \(params)")
                    debugPrint(value)
                    success(value)
                } else {
                    debugPrint("fail read response.result.value not key value pair")
                }
            case .failure(let error):
                failure(error)
                debugPrint("fail get \(urlString), params \(params), error:\(error)")
            }
        }
    }
    
    /*
     func upload(urlString: String, datas: Array<Dictionary<String, Data>>, success: @escaping (_ response: [String: AnyObject])->(), failure: @escaping (_ error: Error)->()) {
     let headers = ["content-type":"multipart/form-data"]
     Alamofire.upload(multipartFormData: { multipartFormData in
     for (index, dic) in datas.enumerated() {
     for (name, data) in dic {
     multipartFormData.append(data, withName: "\(name)\(index)", fileName: "\(name)\(index).jpeg", mimeType: "image/jpeg")
     }
     }
     }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: "\(httpBaseUrl)\(urlString)?token=\(UserDefaults.userInfo.token!)", method: .post, headers: headers) { (encodingResult) in
     switch encodingResult {
     case .success(let upload, _, _):
     upload.responseJSON { response in
     switch response.result {
     case .success:
     if let value = response.result.value as? [String: AnyObject] {
     debugPrint("succ upload \(urlString), data \(datas)")
     debugPrint(value)
     success(value)
     } else {
     debugPrint("fail upload response.result.value not key value pair")
     }
     case .failure(let error):
     failure(error)
     debugPrint("fail upload \(urlString), data \(datas), error:\(error)")
     }
     }
     case .failure(let error):
     failure(error)
     debugPrint("fail upload \(urlString), data \(datas), error:\(error)")
     }
     }
     
     //        Alamofire.upload(multipartFormData: { multipartFormData in
     //            for dic: Dictionary<String, Data> in datas {
     //                for (name, data) in dic {
     //                    multipartFormData.appendBodyPart(data, withName: "image1", fileName: "image1.jpeg", mimeType: "image/jpeg")
     //                }
     //            }
     //        }, to: "\(httpBaseUrl)\(urlString)?token=\(UserDefaults.userInfo.token!)") { (encodingResult) in
     //            switch encodingResult {
     //            case .success(let upload, _, _):
     //                upload.responseJSON { response in
     //                    switch response.result {
     //                    case .success:
     //                        if let value = response.result.value as? [String: AnyObject] {
     //                            debugPrint("succ upload \(urlString), data \(datas)")
     //                            debugPrint(value)
     //                            success(value)
     //                        } else {
     //                            debugPrint("fail upload response.result.value not key value pair")
     //                        }
     //                    case .failure(let error):
     //                        failure(error)
     //                        debugPrint("fail upload \(urlString), data \(datas), error:\(error)")
     //                    }
     //                }
     //            case .failure(let error):
     //                failure(error)
     //                debugPrint("fail upload \(urlString), data \(datas), error:\(error)")
     //            }
     //        }
     }
     */
    
}
