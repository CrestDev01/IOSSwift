//
//  MainTabBarViewController.swift
//  ClothingIndustry
//
//  Created by Nikhil Patel on 13/03/20.
//  Copyright © 2020 Crest Infosystems. All rights reserved.
//

import UIKit


class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fillChildViewControllers()
        self.delegate = self
        DispatchQueue.main.async {
            self.updateColorAppearance()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    internal func updateColorAppearance() {
        self.tabBar.tintColor = CustomColors.color_blackColor
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}

extension MainTabBarViewController {
    
 public enum TabItem: Int, CaseIterable {
        
        case home = 1
        case profile
        case setting
        
        var index: Int {
            switch self {
                case .home:         return 0
                case .profile:      return 1
                case .setting:      return 2
            }
        }
        
        var title: String {
            switch self {
                case .home:             return "Home"
                case .profile:          return "Profile"
                case .setting:          return "Settings"
            }
        }
        
        var image: UIImage {
            switch self {
                case .home:             return AppConstant.Image.Tabbar.icTabHome
                case .profile:          return AppConstant.Image.Tabbar.icTabProfile
                case .setting:          return AppConstant.Image.Tabbar.icTabSetting
            }
        }
    

        static func getEnum(_ index: Int) -> TabItem {
            if index == TabItem.home.index {
                return TabItem.home
            }else if index == TabItem.profile.index {
                return TabItem.profile
            }
            else{
                return TabItem.setting
            }
        }
        
    }
    
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
      
        return true
    }
    
}

extension MainTabBarViewController {
    
    func fillChildViewControllers(){
        
        DispatchQueue.main.async {
            
            UITabBar.appearance().barTintColor = .black
            let firstVc = UIStoryboard.getViewController(fromStoryboard: .home , withIdentifier: AppConstant.viewcontroller.toDoListVC)
            firstVc.tabBarItem = UITabBarItem(title: TabItem.home.title, image: TabItem.home.image, tag: 0)
            let firstNavVc = UINavigationController(rootViewController: firstVc)
            
            let secondVc = UIStoryboard.getViewController(fromStoryboard: .home , withIdentifier: AppConstant.viewcontroller.profileVC)
            secondVc.tabBarItem = UITabBarItem(title: TabItem.profile.title, image: TabItem.profile.image, tag: 1)
            let secondNavVc = UINavigationController(rootViewController: secondVc)
            
            
            let thirdVc = UIStoryboard.getViewController(fromStoryboard: .home , withIdentifier: AppConstant.viewcontroller.settingVC)
            thirdVc.tabBarItem = UITabBarItem(title: TabItem.setting.title, image: TabItem.setting.image, tag: 2)
            let thirdNavVc = UINavigationController(rootViewController: thirdVc)
            self.viewControllers = [firstNavVc , secondNavVc, thirdNavVc]
        }
        
    }
}
