//
//  LSpaceViewController.swift
//  Healthy
//
//  Created by Liang on 17/6/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import MWPhotoBrowser
import HandyJSON

class LSpaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate, LPhotoToolbarDelegate, LHospitalFooterViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var rowID: String!
    
    let request = LRequstXml.share
    
    var myData: Array<LSpaceModel> = []
    
    var isfirstAppear = true
    
    //MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.setupNavigationItem()
        self.setupTableView()
        self.setupAddView()
        
        isfirstAppear = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isfirstAppear == true {
            self.loadData()
            isfirstAppear = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Init
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "大哥大de空间"
        navBar.titleLabel.textColor = UIColor.white
        navBar.titleLabel.frame = CGRect.init(x: UIScreen.main.bounds.width / 2 - 80, y: 0, width: 160, height: 44)
        
        navBar.rightButton.addTarget(self, action: #selector(self.more), for: .touchUpInside)
        navBar.rightButton.setImage(UIImage.init(named: "icon_search"), for: .normal)
        
        navBar.leftButton.addTarget(self, action: #selector(self.backToLast), for: .touchUpInside)
        navBar.leftButton.setImage(UIImage.init(named: "icon_back_white"), for: .normal)
        self.view.addSubview(navBar)
    }
    
    func setupAddView() {
        let addButton = UIButton.init(type: .contactAdd)
        self.view.addSubview(addButton)
        
        addButton.frame = CGRect.init(x: screenWidth - 80, y: screenHeight - 80, width: 60, height: 60)
        addButton.backgroundColor = LColor
        addButton.addTarget(self, action: #selector(self.addButtonAction), for: .touchUpInside)
        
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        
        addButton.layer.shadowColor = UIColor.gray.cgColor
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOffset = CGSize.init(width: 5, height: 5)
    }
    
    func addButtonAction() {
        self.performSegue(withIdentifier: "toRelease", sender: nil)
        
    }
    
    func setupTableView()  {
        self.myTableView.register(UINib.init(nibName: "LSpaceScriptCell", bundle: nil), forCellReuseIdentifier: "LSpaceScriptCell")
        self.myTableView.register(UINib.init(nibName: "LSpaceImageCell", bundle: nil), forCellReuseIdentifier: "LSpaceImageCell")
        self.myTableView.rowHeight = 105
        
//        self.myTableView.tableFooterView = self.initTableFooterView()
        
        //设置tableViewHeader
//        self.myTableView.tableHeaderView = self.initTableHeaderView()
//        self.myTableView
    }
    
    func initTableHeaderView() -> UIView {
        let headerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)! [7] as! LSpaceHeaderView
        
        headerView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 330)
        
        return headerView
    }
    
    func initTableFooterView() -> UIView  {
        let footerView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![5] as! LHospitalFooterView
        
        footerView.myDelegate = self
        
        return footerView
    }
    
    func loadData() {
        let hud = MBProgressHUD.showAdded(to: self.navigationController?.view, animated: true)
       
        request.requestDataWith(tableName: "O34", dataStr: rowID)
        request.getData = {
            dataDic in
            let theArray = dataDic["Tabel"]
            
            for myArray in theArray as! Array<Any> {
                if let theData = JSONDeserializer<LSpaceModel>.deserializeFrom(dict: myArray as? NSDictionary) {
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

    }
    
    //MARK: - Action
    func more() {
        
    }
    
    func backToLast() {
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    var selectIndex = 0
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![10] as! LPhotoToolbar
        customView.frame = CGRect.init(x: 0, y: screenHeight - 60, width: screenWidth, height: 60)
        customView.myDelegate = self
        
        let browser = MWPhotoBrowser.init(delegate: self)
        browser?.view.addSubview(customView)
        browser?.displayActionButton = false
        
        
        self.navigationController?.pushViewController(browser!, animated: true)
        selectIndex = indexPath.row
    }
    // MARK: - UITableViewDataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.myData[indexPath.row]
        
        if model.imagePath.count == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LSpaceScriptCell", for: indexPath) as! LSpaceImageCell
            
            cell.model = self.myData[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LSpaceImageCell", for: indexPath) as! LSpaceImageCell
            
            cell.model = self.myData[indexPath.row]
            
            return cell
        }
        
        
    }

    // MARK: - MWPhotoBrowserDelegate
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        let model = self.myData[selectIndex]
        let count = model.imagePath.count - 1
        
        return UInt(count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let model = self.myData[selectIndex]
        let photo = MWPhoto.init(url: URL.init(string: model.imagePath[Int(index)]) )
        
//        let photo = MWPhoto.init(image: UIImage.init(named: "healthy_main"))
        return photo
    }
    
    func photoBrowserDidFinishModalPresentation(_ photoBrowser: MWPhotoBrowser!) {
        print("photoBrowserDidFinishModalPresentation")
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, didDisplayPhotoAt index: UInt) {
        print("didDisplayPhotoAt")
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, titleForPhotoAt index: UInt) -> String! {
        print("titleForPhotoAt")
        let model = self.myData[selectIndex]
        return "\(index)/\(model.imagePath.count - 1)"
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt, selectedChanged selected: Bool) {
        print("selectedChanged")
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, actionButtonPressedForPhotoAt index: UInt) {
        print("actionButtonPressedForPhotoAt")
    }
    
    /*
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, captionViewForPhotoAt index: UInt) -> MWCaptionView! {
        let cView = MWCaptionView.init(photo: photoBrowser.photo(at: index))
//        cView?.clipsToBounds = false
//        cView?.sizeToFit()
//        let customView = Bundle.main.loadNibNamed("LHealthy", owner: self, options: nil)![10] as! LPhotoToolbar
//        customView.frame = CGRect.init(x: 0, y: -20, width: screenWidth - 16, height: 60)
//
//        let bar = UIBarButtonItem.init(customView: customView)
//        cView?.setItems([bar], animated: true)
        
//        cView?.addSubview(customView)
        
        return cView
    }
    */
    
    // MARK: - LHospitalFooterViewDelegate
    func sendHeartToDoctor() {
        
    }
    
    func attentionDoctor() {
        
    }
    
    func consultationDoctor() {
        self.performSegue(withIdentifier: "toPay", sender: nil)
    }

    // MARK: - LPhotoToolbarDelegate
    func supportAction(sender: UIButton) {
        
    }
    
    func commentAction(sender: UIButton) {
        
    }
    
    func countAction(sender: UIButton) {
        let model = self.myData[selectIndex]
        
        let spaceDetail = UIStoryboard.init(name: "LHealthy", bundle: nil).instantiateViewController(withIdentifier: "spaceDetail") as! LSpaceDetailViewController
        spaceDetail.lastModel = model
        
        self.navigationController?.pushViewController(spaceDetail, animated: true)
//        spaceDetail.rowID =
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            
        }
    }
    

}
