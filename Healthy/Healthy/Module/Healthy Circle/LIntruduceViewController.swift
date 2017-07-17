//
//  LIntruduceViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/14.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import HandyJSON
import SDWebImage

class LIntruduceViewController: UIViewController {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var hospital: UILabel!
    
    @IBOutlet weak var goodatIntruduce: UILabel!
    @IBOutlet weak var educationBackgroud: UILabel!
    @IBOutlet weak var prizeIntruduce: UILabel!
    @IBOutlet weak var shareNUmber: UILabel!
    @IBOutlet weak var intoCircle: UIButton!
    
    var myData: Array<LDoctoeDetailModel> = []
    
    //MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.intoCircle.layer.cornerRadius = 5
        self.intoCircle.layer.masksToBounds = true
        
        setupNavigationItem()
        self.loadData()
//        reloadViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Init
    func reloadViews() {
        let model = self.myData.first! as LDoctoeDetailModel
        
        self.headImage.sd_setImage(with: URL.init(string: model.imageUrl), placeholderImage: nil)
        self.name.text = model.name
        self.subject.text = model.department
        self.position.text = model.grade
        self.hospital.text = model.hospitalName
        self.goodatIntruduce.text = model.goodAtDesc
        self.educationBackgroud.text = model.medicalBackground
        self.prizeIntruduce.text = model.academicResearchResult
        self.shareNUmber.text = "经典案例分享数目：" + model.samplePlan + "例"
        
    }
    
    func loadData() {
        getRequest(route: "doctors/1") { (error, data) in
            //     print("data", data)
            
            if data != nil {
                //各种转换要死啊
                let dataDic = data! as? NSDictionary
                let dataArray = dataDic!.object(forKey: "data")!
                let theDic = dataArray as? NSDictionary
                
                if let theData = JSONDeserializer<LDoctoeDetailModel>.deserializeFrom(dict: theDic) {
                    self.myData.append(theData)
//                        print(theData.grade, theData.goodAt)
                    
                }
                DispatchQueue.main.async {
                     self.reloadViews()
                }
               
            }
        }
    }

    @IBAction func gotoCircle(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toHospital", sender: nil)
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "医生介绍"
        navBar.titleLabel.textColor = UIColor.black
        
        navBar.leftButton.addTarget(self, action: #selector(self.backToLast), for: .touchUpInside)
        navBar.leftButton.setImage(UIImage.init(named: "icon_back_green"), for: .normal)
        self.view.addSubview(navBar)
    }
    
    // MARK: - Action
    
    func backToLast()  {
        _ = self.navigationController?.popViewController(animated: true)
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
