//
//  LUserTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LUserViewController: LBaseViewController {
    
    var data: [Any] = []
    
    
    // MARK: - SystemMethod
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        setupNavigationItem()
        setupTableView()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init
    func initData() {
        
        data = [["我的金币"], ["健康档案", "开通会员"], ["新闻健康"], ["推荐给朋友", "设置与帮助", "健康圈客服", "意见反馈"]]
    }
    
    func setupTableView() {
        self.myTableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 29 - 8)
        //        self.myTableView.bounds = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 48)
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        self.myTableView.tableHeaderView = initTableHeaderView()
        self.myTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1))
        self.myTableView.register(UINib.init(nibName: "LUserCell", bundle: nil), forCellReuseIdentifier: "LUserCell")
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.rightButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        navBar.rightButton.setImage(UIImage.init(named: "tabBar_healthy"), for: .normal)
        self.view.addSubview(navBar)
        
    }
    
    func initTableHeaderView() -> UIView {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140))
        view.backgroundColor = LColor
        
        let headView = Bundle.main.loadNibNamed("LUser", owner: self, options: nil)![0] as! LUserHeadImageView
        view.addSubview(headView)
        
        
        headView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: UIScreen.main.bounds.width, height: 60))
        
        let typeView = Bundle.main.loadNibNamed("LUser", owner: self, options: nil)![1] as! LUserTypeView
        view.addSubview(typeView)
        
        typeView.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 80), size: CGSize.init(width: UIScreen.main.bounds.width, height: 60))
        
        return view
        
    }
    
    func search() {
        
    }
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let detailData = data[section] as! Array<String>
        
        
        return detailData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LUserCell", for: indexPath) as! LUserCell
        
        let detailData = data[indexPath.section] as! Array<String>
        
        cell.selectionStyle = .none
        cell.optionTitle.text = detailData[indexPath.row]
        if indexPath.section != 0 {
            cell.optionDetail.isHidden = true
        }
        // Configure the cell...

        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
