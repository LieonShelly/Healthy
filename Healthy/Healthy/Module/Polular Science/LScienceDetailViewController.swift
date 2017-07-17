//
//  LScienceDetailViewController.swift
//  Healthy
//
//  Created by Liang on 17/7/3.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import MBProgressHUD
import HandyJSON

class LScienceDetailViewController: UIViewController {

    var detailID: String!
    var userID: String! = "0001-1023"
    
    
    var myData: Array<LScienceDetailModel> = []
    
    var isFirstAppear = true
    
    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.isFirstAppear = true
        self.setupNavigationItem()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstAppear {
            isFirstAppear = false
            
            self.loadData()
        }
        
    }
    
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "详情"
        navBar.titleLabel.textColor = UIColor.white
        
        navBar.leftButton.addTarget(self, action: #selector(self.backToLast), for: .touchUpInside)
        navBar.leftButton.setImage(UIImage.init(named: "icon_back_white"), for: .normal)
        self.view.addSubview(navBar)
        
    }
    
    func backToLast() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    let request = LRequstXml.share
    func loadData()
    {
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)
                
        request.requestDataWith(tableName: "O22", dataStr: self.detailID + "," + self.userID)
        request.getData = { dataDic in
            let theArray = dataDic["Tabel"]
            
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LScienceDetailModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    
                    self.myData.append(theData)
                    
                    //                        print(theData.title, theData.detail)
                }
            }
            
            DispatchQueue.main.async {
                hud?.hide(true)
                let model = self.myData[0]
                
                self.myWebView.loadHTMLString(model.Data, baseURL: nil)
            }
        }
        
        request.requestError = { errorString in
            hud?.hide(true)
            
        }
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
