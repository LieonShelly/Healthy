//
//  LHealthyTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON
import MBProgressHUD

class LHealthyViewController: LBaseViewController, LHealthyHeaderViewDelegate {
    
//    var myData: Array<LHealthyTypeModel> = []
    var typeData: Array<LHealthyTypeModel> = []
    
    var hub: MBProgressHUD! = nil
    
// MARK: - SystemMethod
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()
        setupTableView()
        self.loadTypeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
        self.myTableView.register(UINib.init(nibName: "LHealthyCell", bundle: nil), forCellReuseIdentifier: "healthyCell")
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        navBar.titleLabel.text = "健康圈"
        navBar.titleLabel.textColor = UIColor.white
        navBar.rightButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        navBar.rightButton.setImage(UIImage.init(named: "icon_search"), for: .normal)
        self.view.addSubview(navBar)
        
    }
    
    var tagHeaderView: LHealthyHeaderView!
    
    func initTableHeaderView() -> UIView {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![0] as! LHealthyHeaderView
        headerView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        headerView.delegate = self
        
        tagHeaderView = headerView
        
        return headerView
    }
    
    let request = LRequstXml.share
    let logRequest = LRequstXml.share
    
    func loadTypeData() {
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)
        
//        request.createSocket(tableName: "O1", dataStr: "")
        request.requestDataWith(tableName: "O1", dataStr: "")
        request.getData = { dataDic in
            
            let theArray = dataDic["Tabel"]
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LHealthyTypeModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    if theData.PID == "00000" {
                        self.typeData.append(theData)
                    }
                    else {
                        for model in self.typeData {
                            if theData.PID == model.RowID {
                                model.dataArray.append(theData)
                            }
                        }
                    }
                }
            }
            
//            let model = self.typeData[0]
            
            DispatchQueue.main.async {
                hud?.hide(true)
                
                self.tagHeaderView.modelArray = self.typeData
                self.myTableView.reloadData()
                self.loadData("")
            }
            
            
        }
        request.requestError = {
            errorString in
           print(errorString)
            hud?.hide(true)
        }
    }
    
    func loadData(_ rowID: String) {
        
//        if UserInfo.share.getUserID() == nil {
        logRequest.requestDataWith(command: "F000", tableCom: "0", tableName: "", dataStr: "C0001@$^$@12345678")
        
        logRequest.getData = { dataDic in
            
        }
//        }
        
//        0001-1023
        
        /*
        request.createSocket(tableName: "O11", dataStr: rowID)
        request.getData = { dataDic in
            let theArray = dataDic["Tabel"]
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LHealthyModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.myData.append(theData)
                }
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
 */
//        request.createSocket(tableName: "O", dataStr: "")
        
        
    }
    
    // MARK: - Action
    func search() {
        let logVC = UIStoryboard.init(name: "LLog", bundle: nil).instantiateInitialViewController()
        
        self.present(logVC!, animated: true, completion: nil);
        
    }
    
    var selectIndex = 0
    
    // MARK: - LHealthyHeaderViewDelegate
    func typeChanged(sender: UIButton) {
        print(sender.tag)
        selectIndex = sender.tag - 100
        self.myTableView.reloadData()
    }
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.typeData.count > 0 {
            let model = self.typeData[selectIndex]
            return model.dataArray.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: LHealthyCell = tableView.dequeueReusableCell(withIdentifier: "healthyCell", for: indexPath) as! LHealthyCell
        cell.selectionStyle = .none
        let model = self.typeData[selectIndex]

        cell.model = model.dataArray[indexPath.row]
        // Configure the cell...
//    self.view
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    var rowID = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(1111)
        
        let model = self.typeData[selectIndex].dataArray[indexPath.row]
        rowID = model.RowID
        
        self.performSegue(withIdentifier: "toSubject", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubject" {
            let subjectVC = segue.destination as! LSubjectViewController
            subjectVC.rowID = rowID
        }
    }

}


