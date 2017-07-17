//
//  LMyCircleTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON

class LMyCircleViewController: LBaseViewController, LCircleTypeViewDelegate, UIPopoverPresentationControllerDelegate {
    
    var userID: String! = "0001-1023"
    
    var myData: Array<LNowServiceModel> = []
    
    // MARK: - SystemMethod
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupNavigationItem()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init
    func setupTableView() {
        self.myTableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 29 - 8)
        //        self.myTableView.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 48)
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        self.myTableView.tableHeaderView = initTableHeaderView()
        self.myTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1))
        self.myTableView.register(UINib.init(nibName: "LMyCircleCell", bundle: nil), forCellReuseIdentifier: "LMyCircleCell")
        self.myTableView.register(UINib.init(nibName: "LMyDoctorCell", bundle: nil), forCellReuseIdentifier: "LMyDoctorCell")
        self.myTableView.register(UINib.init(nibName: "LAllServiceCell", bundle: nil), forCellReuseIdentifier: "LAllServiceCell")

    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
         navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "我的服务"
        navBar.titleLabel.textColor = UIColor.white
        
        navBar.rightButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        navBar.rightButton.setImage(UIImage.init(named: "tabBar_healthy"), for: .normal)
        self.view.addSubview(navBar)
    }
    
    func initTableHeaderView() -> UIView {
        let view = Bundle.main.loadNibNamed("LCricle", owner: self, options: nil)![0] as! LCircleTypeView
        
        view.myDelegate = self
        
        return view
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstAppear == true {
            self.loadData()
        }
        isFirstAppear = false
    }
    
    let request = LRequstXml.share
    
    func loadData() {
        
        //病人查看圈子列表
        request.requestDataWith(tableName: "O31", dataStr: "0001-1023")
        request.getData = { dataDic in
            print("liebiao")
            
        }
        
//        request.createSocket(tableName: "O32", dataStr: "0001-1023")
//        request.getData = { dataDic in
//            print("tuwen")
//        }
        
//        request.createSocket(tableName: "O33", dataStr: "")
//        request.getData = { dataDic in
//            print("yisheng")
//        }
        
        }
    
    // MARK: - Action
    func search() {
        
        MXWechatPayHandler.jumpToWxPay()
//        LWXPay().startWXPay()
        
//        self.wxPay()
    }
    
    func wxPay() {
        let req = PayReq.init()
        req.openID = "wxcc3c5a4360af8ac2"
        
        req.partnerId = "1470716602"
        
        req.prepayId = ""
        
        req.package = "Sign=WXPay"
        
        req.nonceStr = ""
        
        let stamp = "111"
        
        req.timeStamp = UInt32(stamp)!
        
        req.sign = "dodfg0147258369jkdjkkdkdkjdssdfs"
        
        WXApi.send(req)
    }
    
    
    func filterService(sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "LMain", bundle: nil).instantiateViewController(withIdentifier: "popover")
        
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize.init(width: screenWidth, height: 200)
        
        
        let popover = vc.popoverPresentationController
        
        popover?.barButtonItem = UIBarButtonItem.init(customView: sender)
//        popover?.sourceRect = sender.frame
//            CGRect.init(x: 0, y: 0, width: 100, height: 100)
//        popover?.sourceView = sender
        popover?.delegate = self
//        popover?.arrowDirection = .up
//        popover?.permittedArrowDirections = 
//        popover?.pop
        
        present(vc, animated: true, completion: nil)
        
    }
    
    var selectType = 0
    // MARK: - LCircleTypeViewDelegate
    func typeChanged(_ index: Int) {
        selectType = index
        self.myTableView.reloadData()
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        switch selectType {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch selectType {
        case 0:
            return self.myData.count
        case 1:
            return 3
        case 2:
            return self.myData.count
        default:
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch selectType {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LMyCircleCell", for: indexPath) as! LMyCircleCell
            
            cell.selectionStyle = .none
            cell.model = self.myData[indexPath.row]
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LMyDoctorCell", for: indexPath) as! LMyDoctorCell
            
            cell.selectionStyle = .none
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LAllServiceCell", for: indexPath) as! LAllServiceCell
            
            cell.selectionStyle = .none
            cell.model = self.myData[indexPath.row]

            
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch selectType {
        case 0:
            return 95
        case 1:
            return 72
        case 2:
            return 120
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch selectType {
        case 0:
            return 8
        case 1:
            return 70
        case 2:
            return 40
        default:
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: UIView!
        
        switch selectType {
        case 0:
            view = UIView.init()
        case 1:
            view = Bundle.main.loadNibNamed("LCricle", owner: self, options: nil)![1] as! LMyCircleHeaderView
            
//            view.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: screenWidth, height: 60))
            
            
        case 2:
            view = UIView.init()
            view.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: screenWidth, height: 40))
            let filter = UIButton.init(type: .custom)
            filter.center = CGPoint.init(x: screenWidth - 60, y: 20)
            filter.bounds =  CGRect.init(x: 0, y: 0, width: 120, height: 20)
            filter.setTitle("筛选服务", for: .normal)
            filter.setTitleColor(LColor, for: .normal)
            filter.setImage(UIImage.init(named: "tabBar_healthy"), for: .normal)
            filter.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            filter.addTarget(self, action: #selector(self.filterService(sender:)), for: .touchUpInside)
            view.addSubview(filter)

        default:
            view = UIView.init()
        }
        
        return view!
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch selectType {
        case 0:
            self.performSegue(withIdentifier: "toQuestion", sender: self)
        case 1:
            let vc = UIStoryboard.init(name: "LHealthy", bundle: nil).instantiateViewController(withIdentifier: "hospital")
            self.navigationController?.pushViewController(vc, animated: true)
            
//        case 2:
        default:
            break
        }
        
    }
    
    //MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
