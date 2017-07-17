//
//  LMoreCaseViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/15.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LMoreCaseViewController: LBaseViewController {

    @IBOutlet weak var askForDoctor: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadViews()
        setupTableView()
        setupNavigationItem()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init
    
    func reloadViews()  {
        self.askForDoctor.layer.cornerRadius = 5
        self.askForDoctor.layer.masksToBounds = true
        self.askForDoctor.backgroundColor = LColor
        self.view.bringSubview(toFront: self.askForDoctor)
        
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
    
    func setupTableView() {
        self.myTableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        
        self.myTableView.separatorStyle = .none
        self.myTableView.bounces = false
        self.myTableView.sectionFooterHeight = 0.01
        self.myTableView.sectionHeaderHeight = 0.01
        self.myTableView.rowHeight = 120
        
        self.myTableView.tableHeaderView = initTableHeaderView()
        self.myTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        self.myTableView.register(UINib.init(nibName: "LHospitalCell", bundle: nil), forCellReuseIdentifier: "LHospitalCell")
    }
    
    func initTableHeaderView() -> UIView {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![6] as! LCaseHeaderView
        
        return headerView
    }
    
    // MARK: - Action
    func backToLast()  {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goPayQustion(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toPay", sender: nil)
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LHospitalCell", for: indexPath) as! LHospitalCell
        cell.selectionStyle = .none
        
        cell.model = LHospitalModel()
        
        // Configure the cell...
        
        return cell
    }
    // MARK: - UITableViewDelegate
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    

}
