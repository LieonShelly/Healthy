//
//  LScienceTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON
import MBProgressHUD

class LScienceViewController: LBaseViewController, LScienceHeaderViewDelegate, LImageScrollViewDataSource {

    var myData: Array<LScienceCellModel> = []
    var typeArray: Array<LScienceTypeModel> = []
    
    var tableHeaderView: LScienceHeaderView!
    
    var hub: MBProgressHUD! = nil

    
    // MARK: - SystemMethod

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.setupNavigationItem()
        setupTableView()
        self.loadTypeData()
//        self.tableView.tableHeaderView = initTableHeaderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Init
    func setupTableView() {
        self.myTableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 29 - 5)
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        self.myTableView.tableHeaderView = initTableHeaderView()
        self.myTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1))
        self.myTableView.register(UINib.init(nibName: "LScienceCell", bundle: nil), forCellReuseIdentifier: "LScienceCell")
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        navBar.titleLabel.text = "科普"
        navBar.titleLabel.textColor = UIColor.white

        navBar.rightButton.addTarget(self, action: #selector(self.notice), for: .touchUpInside)
        navBar.rightButton.setImage(UIImage.init(named: "tabBar_healthy"), for: .normal)
        self.view.addSubview(navBar)
        
    }
    
    func initTableHeaderView() -> UIView {
        let headerView = LScienceHeaderView()
        headerView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        headerView.delegate = self
        
        tableHeaderView = headerView
        
        return headerView
    }
    
    let requstType = LRequstXml.share
    func loadTypeData()
    {
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)
        
        
//        showAdded(to: self.navigationController?.view, animated: true)

//        requstType.createSocket(tableName: "O2", dataStr: "")
        requstType.requestDataWith(tableName: "O2", dataStr: "")
        requstType.getData = { dataDic in
            let theArray = dataDic["Tabel"]
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LScienceTypeModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.typeArray.append(theData)
                    //                        print(theData.title, theData.detail)
                }
            }
            
            DispatchQueue.main.async {
                hud?.hide(true)
                self.tableHeaderView.modelArray = self.typeArray
                let model = self.typeArray[0]
                self.loadData(model.RowID)
            }
        }
        
        requstType.requestError = { errorString in
            hud?.hide(true)
            
        }
    }
    
    let requstContent = LRequstXml.share
    
    func loadData(_ id: String) {
        self.myData.removeAll()
        self.myTableView.reloadData()
        
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)
        
//        requstContent.createSocket(tableName: "O21", dataStr: id)
        requstContent.requestDataWith(tableName: "O21", dataStr: id)
        requstContent.getData = { dataDic in
            let theArray = dataDic["Tabel"]
            
            print("getdata")
            
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LScienceCellModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.myData.append(theData)
                }
            }
            
            DispatchQueue.main.async {
                hud?.hide(true)
                self.myTableView.reloadData()
            }
        }
        
        requstContent.requestError = { errorString in
            print(errorString)
            
            hud?.hide(true)
        }
        
        /*
        getRequest(route: "news?categories=1&page=1&per_page=5&order=desc", parameters: nil) { (error, data) in
            //            print("data", data)
            
            if data != nil {
                //各种转换要死啊
                let dataDic = data! as? NSDictionary
                let dataArray = dataDic!.object(forKey: "data")!
                let theArray = dataArray as? Array<Any>
                
                for myArray in theArray! {
                    if let theData = JSONDeserializer<LScienceCellModel>.deserializeFrom(dict: myArray as? NSDictionary) {
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
    func notice() {
        
    }
    
    // MARK: - LImageScrollViewDataSource
    func images() -> [Any] {
        
        let image = UIImage.init(named: "tabBar_healthy")
        
        return [image!, image!]
    }
    func titles() -> [String]? {
        return ["z这是什么鬼", "z这you是什么鬼"]
    }
    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("numSection")
        if self.typeArray.count > 0 {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("numRow")
        return self.myData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LScienceCell = tableView.dequeueReusableCell(withIdentifier: "LScienceCell", for: indexPath) as! LScienceCell
        cell.selectionStyle = .none
        cell.model = self.myData[indexPath.row]
        
        // Configure the cell...
        print("cell")
        return cell
    }
 
    
    // MARK: - UITableViewDelegate
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = self.typeArray[section]
        print("heightSection")
        if  model.ImgePath != "" {
            return 100
        }
        else {
          return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("height")
        return 96
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("headerSection")
        let view = UIView.init()
        let model = self.typeArray[section]
        
        if  model.ImgePath != "" {
            view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
            let scrollView = LImageScrollView()
            scrollView.myDataSource = self
            
            scrollView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
            view.addSubview(scrollView)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        self.performSegue(withIdentifier: "toDetail", sender: cell)
    }
    
//    var selectType: Int = 0
    
    // MARK: - LScienceHeaderViewDelegate
    func typeChanged(sender: UIButton) {
        print(sender.tag)
//        self.selectType = sender.tag - 100
//        self.tableView.tableHeaderView = initTableHeaderView()
//        self.myTableView.reloadData()
        let model = self.typeArray[sender.tag - 100]
        
        self.loadData(model.RowID)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.myTableView.indexPath(for: cell)
            let model = self.myData[(indexPath?.row)!]
            
            let detailVc = segue.destination as! LScienceDetailViewController
            detailVc.detailID = model.RowID
            
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
