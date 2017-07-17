//
//  LHospitalTableViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/7.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LHospitalViewController: LBaseViewController, LHospitalHeaderViewDataSource, LHospitalHeaderViewDelegate, LHospitalFooterViewDelegate, LHospitalSectionHeaderViewDelegate, LHospitalCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Init
    func setupTableView() {
        self.myTableView.frame = CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
        
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        self.myTableView.sectionFooterHeight = 0.01
        self.myTableView.sectionHeaderHeight = 0.01
        
        self.myTableView.tableHeaderView = initTableHeaderView()
        self.myTableView.tableFooterView = initTableFooterView()
        self.myTableView.register(UINib.init(nibName: "LHospitalCell", bundle: nil), forCellReuseIdentifier: "LHospitalCell")
    }
    
    func initTableHeaderView() -> UIView {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![3] as! LHospitalHeaderView
        
        headerView.myDelegate = self
        headerView.myDataSource = self
        
        return headerView
    }

    func initTableFooterView() -> UIView  {
        let footerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![5] as! LHospitalFooterView
        
        footerView.myDelegate = self
        
        return footerView
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LHospitalCell", for: indexPath) as! LHospitalCell
        cell.selectionStyle = .none
        
        cell.model = LHospitalModel()
        cell.myDelegate = self
        // Configure the cell...

        return cell
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let theView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![4] as! LHospitalSectionHeaderView
        
        theView.myDelegate = self
        return theView
    }
    
    // MARK: - LHospitalCellDelegate
    func headClick(sender: UIButton) {

    }
    
    // MARK: - LHospitalHeaderViewDataSource
    func dataForViews() -> Any {
        
        return 0
    }
    
    // MARK: - LHospitalHeaderViewDelegate
    func touchShare() {
        print("分享")
    }
    
    func touchBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - LHospitalFooterViewDelegate
    func sendHeartToDoctor() {
        
    }
    
    func attentionDoctor() {
        
    }
    
    func consultationDoctor() {
        self.performSegue(withIdentifier: "toPay", sender: nil)
    }
    
    // MARK: - LHospitalSectionHeaderViewDelegate
    func loadMoreCase() {
        self.performSegue(withIdentifier: "toCase", sender: nil)
    }
    
    
 

}
