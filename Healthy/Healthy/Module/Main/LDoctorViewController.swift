//
//  LDoctorTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON
import MBProgressHUD

class LDoctorViewController: LBaseViewController, LSubTypeViewDelegate, LDoctorCellDelegate {
    
    var rowID = ""
    
    var myData: Array<LDoctorModel> = []
    
    
// MARK: - SystemMethod
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstAppear == true {
            self.loadData()
        }
        isFirstAppear = false
        
    }
    
    // MARK: - Init
    func setupTableView() {
        self.myTableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        //        self.myTableView.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 48)
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        self.myTableView.sectionFooterHeight = 0.01
        self.myTableView.sectionHeaderHeight = 0.01
        
        self.myTableView.tableHeaderView = initTableHeaderView()
        self.myTableView.tableFooterView = initTableFooterView()
        self.myTableView.register(UINib.init(nibName: "LDoctorCell", bundle: nil), forCellReuseIdentifier: "LDoctorCell")
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "健康圈"
        navBar.titleLabel.textColor = UIColor.black
        
        navBar.leftButton.addTarget(self, action: #selector(self.backToLast), for: .touchUpInside)
        
        navBar.leftButton.setImage(UIImage.init(named: "icon_back_green"), for: .normal)
        self.view.addSubview(navBar)
    }
    
    func initTableHeaderView() -> UIView {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![1] as! LSubTypeView
        
        headerView.frame =
            CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        headerView.delegate = self
        return headerView
    }
    
    func initTableFooterView() -> UIView {
        let view = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![2] as! LHealthyFooterView
        view.createMyCircle.layer.cornerRadius = 5
        view.createMyCircle.layer.masksToBounds = true
        view.createMyCircle.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tapCreateMyCircle)))
        
        return view
    }
    
    let requst = LRequstXml.share
    
    func loadData() {
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)

//        requst.createSocket(tableName: "O12", dataStr: rowID)
        requst.requestDataWith(tableName: "O12", dataStr: rowID)
        requst.getData = { dataDic in
            let theArray = dataDic["Tabel"]
            
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LDoctorModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.myData.append(theData)
                }
            }
            
            DispatchQueue.main.async {
                hud?.hide(true)
                self.myTableView.reloadData()
            }
            
        }
        
        requst.requestError = {
            errorString in
            print(errorString)
            
             hud?.hide(true)
        }
        /*
        getRequest(route: "doctors?department=1&sort=1") { (error, data) in
            //            print("data", data)
            
            if data != nil {
                //各种转换要死啊
                let dataDic = data! as? NSDictionary
                let dataArray = dataDic!.object(forKey: "data")!
                let theArray = dataArray as? Array<Any>
                
                for myArray in theArray! {
                    if let theData = JSONDeserializer<LDoctorModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                            self.myData.append(theData)
                            print(theData.grade, theData.goodAt)
                    }
                }
                self.myTableView.reloadData()
            }
        }
 */
    }
    
    // MARK: - Action
    
    func tapCreateMyCircle() {
        print("创建属于自己的圈子")
        self.performSegue(withIdentifier: "toCreateCircle", sender: nil)
    }
    
    func backToLast()  {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - LSubTypeViewDelegate
    func changeType(_ sender: UIButton) {
        
    }
    
    func sortData(_ sender: UIButton) {
        
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LDoctorCell", for: indexPath) as! LDoctorCell

        cell.selectionStyle = .none
        cell.model = self.myData[indexPath.row]
        cell.mydelegate = self
        // Configure the cell...

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(1111)
        let model = self.myData[indexPath.row]
        
        self.performSegue(withIdentifier: "toSpace", sender: model.RowID)
        
    }
    // MARK: - LDoctorCellDelegate
    func headClick(cell: LDoctorCell, sende: UIButton) {
        self.performSegue(withIdentifier: "toIntruduce", sender: nil)

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpace" {
            let spaceVC = segue.destination as! LSpaceViewController
            spaceVC.rowID = sender as! String
            
        }
    }
}
