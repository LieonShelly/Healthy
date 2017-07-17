//
//  LSubjectTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON
import MBProgressHUD

class LSubjectViewController: LBaseViewController {

    var rowID = ""
    
    var myData: Array<LHealthyTypeModel> = []
    
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
        self.myTableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 44 - 8)
        //        self.myTableView.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 48)
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        
        self.myTableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        self.myTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        self.myTableView.register(UINib.init(nibName: "LSubjectCell", bundle: nil), forCellReuseIdentifier: "LSubjectCell")
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "健康圈"
        navBar.titleLabel.textColor = UIColor.white
        
        navBar.rightButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        navBar.rightButton.setImage(UIImage.init(named: "icon_search"), for: .normal)
        
        navBar.leftButton.addTarget(self, action: #selector(self.backToLast), for: .touchUpInside)
        navBar.leftButton.setImage(UIImage.init(named: "icon_back_white"), for: .normal)
        self.view.addSubview(navBar)
        
    }
    
    let request = LRequstXml.share
    func loadData() {
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)

//        request.createSocket(tableName: "O11", dataStr: rowID)
        request.requestDataWith(tableName: "O11", dataStr: rowID)
        request.getData = { dataDic in
            let theArray = dataDic["Tabel"]
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LHealthyTypeModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.myData.append(theData)
                }
            }
            DispatchQueue.main.async {
                hud?.hide(true)
                self.myTableView.reloadData()
            }
        }
        
        request.requestError = {
            errorString in
            print(errorString)
            hud?.hide(true)
        }
        
        /*
        getRequest(route: "diseases?categories=1&page=0", parameters: nil) { (error, data) in
            //            print("data", data)
            
            if data != nil {
                //各种转换要死啊
                let dataDic = data! as? NSDictionary
                let dataArray = dataDic!.object(forKey: "data")!
                let theArray = dataArray as? Array<Any>
                
                for myArray in theArray! {
                    if let theData = JSONDeserializer<LHealthyModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                        self.myData.append(theData)
                        //                        print(theData.title, theData.detail)
                    }
                }
                self.myTableView.reloadData()
            }
        }
 */
    }
    
    // MARK: - Action
    func search() {
        
    }
    
    func backToLast()  {
        _ = self.navigationController?.popViewController(animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "LSubjectCell", for: indexPath) as! LSubjectCell

        cell.selectionStyle = .none
        cell.model = self.myData[indexPath.row]
        print("cell")
        // Configure the cell...

        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(1111)
        let model = self.myData[indexPath.row]
        nextRowID = model.RowID
        
        self.performSegue(withIdentifier: "toDoctor", sender: nil)
        
    }

    var nextRowID = ""
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDoctor" {
                let subjectVC = segue.destination as! LDoctorViewController
                subjectVC.rowID = nextRowID
            }
        
        }
 

}
