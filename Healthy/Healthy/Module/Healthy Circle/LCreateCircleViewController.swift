//
//  LCreateCircleViewController.swift
//  Healthy
//
//  Created by Liang on 17/4/14.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LCreateCircleViewController: UIViewController, UIGestureRecognizerDelegate {

    
    private var phoneNumber: String! = ""
    
    @IBOutlet weak var commitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupNavigationItem()
        reloadViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadViews() {
        self.commitButton.backgroundColor = LColor
        
    }
    
    func setupNavigationItem() {
        let navBar = Bundle.main.loadNibNamed("LMain", owner: self, options: nil)![0] as! LNavigationBar
        navBar.backgroundColor = LColor
        navBar.bgView.backgroundColor = LColor
        
        navBar.titleLabel.text = "上传资料"
        navBar.titleLabel.textColor = UIColor.black
        
        navBar.leftButton.addTarget(self, action: #selector(self.backToLast), for: .touchUpInside)
        navBar.leftButton.setImage(UIImage.init(named: "icon_back_green"), for: .normal)
        self.view.addSubview(navBar)
    }

    // MARK: - Action
   
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if sender.text!.lengthOfBytes(using: .ascii) > 11 {
            sender.text = sender.text!.substring(with: sender.text!.startIndex ..< sender.text!.index(sender.text!.startIndex, offsetBy: 11))
            
        }
        
            self.phoneNumber = sender.text!
        
        
        print(sender.text!)
        print(phoneNumber + "phone")
    }
    
    @IBAction func commitData(_ sender: UIButton) {
        print("提交")
        self.performSegue(withIdentifier: "toWait", sender: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        print("添加图片")
    }
    func backToLast()  {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
//        self.isEditing = false
    }
}
