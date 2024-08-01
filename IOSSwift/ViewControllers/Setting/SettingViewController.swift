//
//  SettingViewController.swift
//  IOSSwift
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation
import UIKit

class SettingViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = SettingTitle
    }
    
    // MARK: - Actions
    @IBAction func didTapLoginButton(_ sender: Any) {
        let yes : UIAlertAction = UIAlertAction(title: YesTitle, style: .default) { UIAlertAction in
            AppConstant.sceneDelegate?.resetToLogin()
        }
        let no : UIAlertAction = UIAlertAction(title: NoTitle, style: .cancel) { _ in
        }
       
        GeneralUtility.showAlert(onVC: self, withTitle: AlertTitle, message: LogoutAlertMesssgae, actions: [yes,no])
        
    }
    
}

