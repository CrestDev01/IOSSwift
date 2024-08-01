//
//  UIApplicationExtension.swift
//  IOSSwift
//
//  Created by CrestAdmin on 30/07/24.
//

import Foundation
import UIKit
extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            //let app = UIApplication.shared
            let statusBarHeight: CGFloat = AppConstant.sceneDelegate?.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
            let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
            statusbarView.accessibilityIdentifier = "CustomStatusBar"
            statusbarView.backgroundColor = CustomColors.color_whiteColor
            if let view = AppConstant.sceneDelegate?.window?.subviews.first(where: {$0.accessibilityIdentifier == "CustomStatusBar"}) {
                view.removeFromSuperview()
            }
            AppConstant.sceneDelegate?.window?.addSubview(statusbarView)
            return statusbarView
        } else if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            return statusBar
        }
        return nil
    }
}
