//
//  AppDelegate.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
//import 

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //向微信注册
        WXApi.registerApp("wxcc3c5a4360af8ac2");
        
        
//        [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];
        
        
        /*
        ShareSDK.registerActivePlatforms([SSDKPlatformType.typeWechat.rawValue], onImport: { (platform : SSDKPlatformType) in
            switch platform
            {
            case SSDKPlatformType.typeWechat:
                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
            default:
                break
            }
            
        }) { (platform : SSDKPlatformType , appInfo : NSMutableDictionary?) in
            switch platform
            {
            case SSDKPlatformType.typeWechat:
                //设置微信应用信息
                appInfo?.ssdkSetupWeChat(byAppId: "wxcc3c5a4360af8ac2",
                                         appSecret: "81ed3ea3bb75e67531b2d9c5a19baa47")
            default:
                break
            }
        }
        */
        
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        
        if LFileManager.share.getToken() == nil {
            let logNav = UIStoryboard.init(name: "LLog", bundle: nil).instantiateInitialViewController()
            self.window?.rootViewController = logNav
            
        } else {
            let mainTabBar = LMainTabBarController()
            //        let mainNav = UINavigationController.init(rootViewController: mainTabBar)
            
            self.window?.rootViewController = mainTabBar
        }
        
        
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: - 微信支付回调
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
   
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func onResp(_ resp: BaseResp!) {
        var payResult = "errorCode:\(resp.errCode)"
        
        if resp.isKind(of: PayResp.classForCoder()) {
            switch resp.errCode {
            case 0:
                payResult = "支付结果：成功！"
            case -1:
                payResult = "支付结果：失败！"
            case -2:
                payResult = "用户已经退出支付！"
            default:
                payResult = "支付结果：失败！retCode = \(resp.errCode) retstr = \(resp.errStr)"
            }
        }
        if resp.isKind(of: SendAuthResp.classForCoder()) {
            let temp = resp as! SendAuthResp
            
            if temp.errCode == 0 {
                let mainTabBar = LMainTabBarController()
                //        let mainNav = UINavigationController.init(rootViewController: mainTabBar)
                
                self.window?.rootViewController = mainTabBar
                let info = LLoginInfo.init()
                info.token = temp.code
                info.userID = "123456"
                LFileManager.share.saveLoginInfo(info: info)
            }
            print(resp.errCode, temp.code, temp.state)
        }
        
        print(payResult)
    }
    
}

