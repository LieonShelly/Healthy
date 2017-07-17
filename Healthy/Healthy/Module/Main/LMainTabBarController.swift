//
//  LMainTabBarController.swift
//  Healthy
//
//  Created by Liang on 17/4/5.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit

class LMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupTabBar (){
        let taoStreetNavVC = UIStoryboard.init(name: "LHealthy", bundle: nil).instantiateInitialViewController()
        taoStreetNavVC?.tabBarItem.title = "健康圈"
//        taoStreetNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_healthy")?.withRenderingMode(.alwaysOriginal)
        taoStreetNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_healthy")
        
        taoStreetNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:UIColor.init(red: 113/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)], for: UIControlState.normal)
        taoStreetNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:LColor], for: UIControlState.selected)
        
        let enterNavVC = UIStoryboard.init(name: "LScience", bundle: nil).instantiateInitialViewController()
        enterNavVC?.tabBarItem.title = "科普"
        enterNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_science")
//        enterNavVC?.tabBarItem.
        //        enterNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_science")?.withRenderingMode(.alwaysOriginal)

        enterNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:UIColor.init(red: 113/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)], for: UIControlState.normal)
        enterNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:LColor], for: UIControlState.selected)
        
       
        
        let printNavVC = UIStoryboard.init(name: "LMyCircle", bundle: nil).instantiateInitialViewController()
        printNavVC?.tabBarItem.title = "我的圈子"
        printNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_circle")
//        printNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_circle")?.withRenderingMode(.alwaysOriginal)

        printNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:UIColor.init(red: 113/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)], for: UIControlState.normal)
        printNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:LColor], for: UIControlState.selected)
        
        let infoNavVC = UIStoryboard.init(name: "LUser", bundle: nil).instantiateInitialViewController()
        infoNavVC?.tabBarItem.title = "个人中心"
        infoNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_user")
//        infoNavVC?.tabBarItem.image = UIImage.init(named: "tabBar_user")?.withRenderingMode(.alwaysOriginal)

        infoNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:UIColor.init(red: 113/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)], for: UIControlState.normal)
        infoNavVC?.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 10.0), NSForegroundColorAttributeName:LColor], for: UIControlState.selected)
        
        self.setViewControllers([taoStreetNavVC!, enterNavVC!,  printNavVC!, infoNavVC!],animated: false)
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let vc = navigationController.viewControllers.first
        if viewController.isEqual(vc) == false {
            viewController.hidesBottomBarWhenPushed = true
        }
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
