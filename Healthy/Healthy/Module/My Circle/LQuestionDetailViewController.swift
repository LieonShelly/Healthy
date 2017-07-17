//
//  LQuestionDetailViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/26.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell_Bell
import SocketIO
import KissXML
import CocoaAsyncSocket


class LQuestionDetailViewController: LBaseViewController,GCDAsyncSocketDelegate, UITextFieldDelegate {
    
    //设成全局，不然会被销毁
    let requst = LRequstXml.share
    var tagBottomView: LQuestionFooterView!
    var myData: Array<String> = {
      return ["什么密密麻麻密密麻麻密密麻麻","啊飒飒说dggggggggg是大叔大叔大叔大叔的三大的是的撒打算打算","韩国哈哈哈哈干活干活干活干活干活","阿斯顿人烦人烦人烦人烦人烦人", "sdhhnsdlashdlasndlasl"]
    }()
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initViews()
        self.setupTableView()
        
//        requst.createSocket(tableName: "O2",)

        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        print(self.asocket.isConnected)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK: - Init
    func setupTableView()  {
        self.myTableView.frame = CGRect.init(x: 0, y: 64 + 56, width: screenWidth, height: screenHeight - 64 - 80 - 56)
        self.myTableView.estimatedRowHeight = 80.0
        self.myTableView.separatorStyle = .none
        
        self.myTableView.register(UINib.init(nibName: "LQuestionDetailCell", bundle: nil), forCellReuseIdentifier: "questionCell")
        
        self.myTableView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tableViewTap(sender:))))
    }
    
    func initViews() {
        let navBar = Bundle.main.loadNibNamed("LCricle", owner: self, options: nil)![4] as! LQuestionBar
        self.view.addSubview(navBar)
//        navBar.backgroundColor = UIColor.white
        navBar.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 64)
        
        let topView = Bundle.main.loadNibNamed("LCricle", owner: self, options: nil)![2] as! LQustionHeaderView
        self.view.addSubview(topView)
        topView.frame = CGRect.init(x: 0, y: 64, width: screenWidth, height: 56)
        
        topView.model = {
            let model = LCircleHeaderModel()
            model.grade = "主任医师"
            model.subject = "内科"
            model.name = "刘易斯"
            model.imageUrl = "icon_leaf"
            model.tapArray = ["三甲医院", "良心典范", "厉害了的", "大医院"]
            return model
        }()
        
        let bottomView = Bundle.main.loadNibNamed("LCricle", owner: self, options: nil)![3] as! LQuestionFooterView
        self.view.addSubview(bottomView)
        bottomView.frame = CGRect.init(x: 0, y: screenHeight - 80, width: screenWidth, height: 80)
        bottomView.inputtextField.delegate = self
        self.tagBottomView = bottomView
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:  NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK: - Action
    func keyboardWillShow(_ notification: Notification) {
        print("show")
        self.reloadViews(notification, true)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        print("hide")
        self.reloadViews(notification, false)
    }
    
    func tableViewTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.tagBottomView.inputtextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func reloadViews(_ notification: Notification, _ isShow: Bool) {
        let userInfo = notification.userInfo as Dictionary!
        
        let douration = userInfo?[UIKeyboardAnimationDurationUserInfoKey]
        
        /*
        let begainRect = (userInfo?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
        let endRect = (userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        print(begainRect, endRect)
        */
        
        let value = userInfo?[UIKeyboardFrameEndUserInfoKey]
        let keyboardRect = (value as AnyObject).cgRectValue
        var height = keyboardRect?.size.height
        if height == 216 {
            return
        }
        var diffHeight: CGFloat = 0
        
        if isShow == false {
//            height = height! * (-1)
            height = 0
        } else {
            let contentHeight = self.myTableView.contentSize.height
            let tableHeight = self.myTableView.bounds.size.height
            
            diffHeight = tableHeight - contentHeight
        }
        
        UIView.animate(withDuration: douration as! TimeInterval, animations: {
            self.myTableView.frame = CGRect.init(x: 0, y: 64 + 56 - height! + diffHeight, width: screenWidth, height: screenHeight - 64 - 80 - 56)
            self.tagBottomView.frame = CGRect.init(x: 0, y: screenHeight - 80 - height!, width: screenWidth, height: 80)
            
        }) { (comp) in
            
        }
        
        print(height!)
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! LQuestionDetailCell
        
        cell.selectionStyle = .none
        cell.model = self.myData[indexPath.row]
        
        return cell
        
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("select")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tagBottomView.inputtextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tagBottomView.inputtextField.resignFirstResponder()
        
    }
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("发送")
        textField.resignFirstResponder()
        return true
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
