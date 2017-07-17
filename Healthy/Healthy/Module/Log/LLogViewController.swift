//
//  LLogViewController.swift
//  Healthy
//
//  Created by Liang on 17/5/31.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LLogViewController: UIViewController {

    @IBOutlet weak var weixinLog: UIButton!
    @IBOutlet weak var userProtocol: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        weixinLog.backgroundColor = LColor
        userProtocol.backgroundColor = LColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logWithWeiXin(_ sender: UIButton) {
        
        if WXApi.isWXAppInstalled() {
            let req = SendAuthReq.init()
            req.scope = "snsapi_userinfo"
            req.state = "APP"
            WXApi.send(req)
        } else {
            self.showAlert()
        }
        /*
        ShareSDK.getUserInfo(SSDKPlatformType.typeWechat) { (state, user, error) in
            if state == SSDKResponseState.success {
                print("uid:\(user?.uid)___cre:\(user?.credential)___token:\(user?.credential.token)___nike:\(user?.nickname)")
            } else {
                print(error)
            }
            
        }*/
    }

    @IBAction func gotoUserProtocol(_ sender: UIButton) {
    }
    
    @IBAction func logWithAcount(_ sender: UIButton) {
    }
    
    @IBAction func regist(_ sender: UIButton) {
    }
    
    func logWithWeixin() {
       
    }
    
    func showAlert() {
        let alert = UIAlertController.init(title: "提示", message: "请先安装微信客户端", preferredStyle: .alert);
        let action = UIAlertAction.init(title: "确定", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
