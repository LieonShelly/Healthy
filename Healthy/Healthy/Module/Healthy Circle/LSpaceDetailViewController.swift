//
//  LSpaceDetailViewController.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON

class LSpaceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    
    var lastModel: LSpaceModel!
    var myData: Array<LSpaceDetailModel> = []
    
    var commentData: Array<LSpaceCommentModel> = []
    var praiceData: Array<LSpaceCommentModel> = []
    
    private var isFirstAppear = true
    
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.setupNavigationItem()
        self.setupTableView()
        isFirstAppear = true
        // Do any additional setup after loading the view.
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
    }
    
    // MARK: - Init
    func setupTableView() {
        self.myTableView.register(UINib.init(nibName: "LSpaceDetailCell", bundle: nil), forCellReuseIdentifier: "LSpaceDetailCell")
        self.myTableView.estimatedRowHeight = 80
//        self.myTableView.estimatedSectionHeaderHeight = 60
        self.myTableView.tableHeaderView = self.InitTableHeaderView()
        
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

    var tagHeaderView: LSpaceDetailHeaderView!
    
    func InitTableHeaderView() -> UIView {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)! [8] as! LSpaceDetailHeaderView
        
        headerView.model = lastModel
        
        tagHeaderView = headerView
        let height = headerView.contentLabel.labelHeight()
        headerView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 230 + CGFloat(height))
        
        return headerView
    }
    
    
    func loadData() {
        LRequstXml.share.requestDataWith(tableName: "O35", dataStr: lastModel.RowID)
        LRequstXml.share.getData = {
            dataDic in
            
            let theArray = dataDic["Tabel"]
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LSpaceDetailModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    self.myData.append(theData)
                    
 
                }
            }
            
            DispatchQueue.main.async {
                self.loadCommentData()
            }
 
        }
    }
    
    func loadCommentData()  {
        LRequstXml.share.requestDataWith(tableName: "O36", dataStr: lastModel.RowID)
        LRequstXml.share.getData = {
            dataDic in
            
            let theArray = dataDic["Tabel"]
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LSpaceCommentModel>.deserializeFrom(dict: myArray as? NSDictionary) {
                    if theData.HTType == "0" {
                        self.praiceData.append(theData)
                    } else {
                        self.commentData.append(theData)
                    }
                    
                }
            }
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
                
            }
        }
    }
    
    // MARK: - Action
    func backToLast()  {
        _ = self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.praiceData.count == 0 {
            return 0
        }
        
        let maxCount = Int((screenWidth - 50) / 30)
        let count = Int(self.praiceData.count / maxCount) + 1
        
        return CGFloat(count * 50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)! [9] as! LSpaceDetailSectionView
//        headerView.
//        headerView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 130)
        if self.praiceData.count != 0{
            headerView.model = self.praiceData
        }
        return headerView
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LSpaceDetailCell", for: indexPath) as! LSpaceDetailCell
        cell.model = self.commentData[indexPath.row]
        return cell
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
