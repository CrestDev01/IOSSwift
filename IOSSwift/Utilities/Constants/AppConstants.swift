//
//  AppConstants.swift
//  IOSSwift
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation
import UIKit

struct AppConstant {
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let appDisplayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
    static let appVersionNumber: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let appBuildNumber: String = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? ""
    static var sceneDelegate: SceneDelegate? {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate else { return nil }
             return delegate
    }
        
    struct Device {
        #if targetEnvironment(simulator)
        static let isSimulator = true
        #else
        static let isSimulator = false
        #endif
        static let isIpad = (UIDevice.current.userInterfaceIdiom == .pad) ? true : false
        static let isIphone = (UIDevice.current.userInterfaceIdiom == .phone) ? true : false
    }
    
    
    struct UserDefaultsKey {
        static let userToken = "userToken"
        static let userLogin = "userLogin"
    }
    
    struct Image {
        struct Tabbar {
            static let icTabHome = UIImage.init(named: "ic_tab_home")!
            static let icTabSetting = UIImage.init(named: "ic_tab_setting")!
            static let icTabProfile = UIImage.init(named: "ic_tab_profile")!
        }
        
        struct icons{
            static let ic_alertError = UIImage.init(named:"ic_alertError")!
            static let ic_alertSuccess = UIImage.init(named:"ic_alertSuccess")!
        }
        
        struct common{
            static let img_personal = UIImage.init(named:"personal")!
            static let img_work = UIImage.init(named:"work")!
            static let image_profile = UIImage.init(named: "profile")!
        }
    }
    
    struct viewcontroller {
        static let welcomeVC = "WelcomeViewController"
        static let loginVC = "LoginViewController"
        static let registerVC = "RegisterViewController"
        static let tabbarVC = "MainTabBarViewController"
        static let toDoListVC = "ToDoListViewController"
        static let addEditJobVC = "AddEditToDoViewController"
        static let settingVC = "SettingViewController"
        static let profileVC = "ProfileViewController"
    }
    
    
}
