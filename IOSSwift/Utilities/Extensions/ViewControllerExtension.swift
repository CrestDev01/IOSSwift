//
//  ViewControllerExtension.swift
//  IOSSwift
//
//  Created by CrestAdmin on 25/07/24.
//

import Foundation
import UIKit
import BRYXBanner
enum Storyboard {
    
    case main
    case home
    
    var name: String {
        switch self {
            case .main:         return "Main"
            case .home:         return "Home"
        }
    }
    
}

extension UIStoryboard {
    
    /**
     Method to init storyboard with specified Storyboard name
     - parameter storyboard: Represent storyboard detail
     - returns UIStoryboard
     */
    class func getStoryboard(from storyboard: Storyboard) -> UIStoryboard {
        return UIStoryboard.init(name: storyboard.name, bundle: nil)
    }
    
    /**
     Method get initial view controller for main storyboard
     - returns UIViewController
     */
    class func getInitialViewController() -> UIViewController? {
        let initialViewController = UIStoryboard.getStoryboard(from: .main).instantiateInitialViewController()
        return initialViewController
    }
    
    /**
     Method to get viewcontoller from storyborad and identifier
     - parameter storyboard: Represent storyboard
     - parameter identifier: Represent viewcontroller identifier
     - returns UIViewController
     */
    class func getViewController(fromStoryboard storyboard: Storyboard, withIdentifier identifier: String) -> UIViewController {
        let viewController = UIStoryboard.getStoryboard(from: storyboard).instantiateViewController(withIdentifier: identifier)
        return viewController
    }
    
}

extension UIViewController{
    
    func pushViewController(with storyboard: Storyboard, viewcontroller identifier: String){
        let vc = UIStoryboard.getViewController(fromStoryboard: storyboard, withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showToastMessageBanner(info: String, error: Bool = false)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var color = UIColor()
            var img = UIImage(named: "") ?? nil
            if(error) {
                color = CustomColors.color_errorRedColor
                img =  AppConstant.Image.icons.ic_alertError
            } else {
                color = CustomColors.color_greenColor//blueyGreen
                img =  AppConstant.Image.icons.ic_alertSuccess
            }
            let banner = Banner(title: "", subtitle: info, image:img, backgroundColor: CustomColors.color_whiteColor)//UIImage(named: "NcheckSel")
                  banner.textColor =  color
            banner.layer.borderWidth = 2
            banner.layer.borderColor = color.cgColor
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
        }
    }
}

