//
//  LoginViewController.swift
//  IOSSwift
//
//  Created by CrestAdmin on 25/07/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: TextFieldRegular!
    @IBOutlet weak var passwordTextField: TextFieldRegular!
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Setting textfield properties
        self.emailTextField.keyboardType = .emailAddress
        self.passwordTextField.isSecureTextEntry = true
        
    }
    

    // MARK: - Actions
    @IBAction func didTapLoginButton(_ sender: Any) {
        
        let paramDic = [
            APIkeyEmail : self.emailTextField.text ?? "",
            APIKeyPassword : self.passwordTextField.text ?? "",
        ] as [String : Any]
        /*
        
         /////  Uncomment to call API, apply validation before calling API
         
        WebServicesCollection.sharedInstance.API_LoginUser(param: paramDic) { success, model in
            if(success){
                UserDefaults.saveString(model!.token, forKey: AppConstant.UserDefaultsKey.userToken)
                AppConstant.sceneDelegate?.token = model!.token ?? ""
                WebServicesCollection.sharedInstance.API_UserDetails() { issuccess, user_model in
                    
                    if(issuccess){
                        do{
                            // save the user login session with token and data
                            AppConstant.sceneDelegate?.loginUser = user_model
                            try UserDefaults.standard.saveObject(user_model, forKey: AppConstant.UserDefaultsKey.userLogin)
                            AppConstant.sceneDelegate?.setFlowAfterLogin()
                        }
                        catch{
                            
                        }
                    }
                }
            }
        }
        
        */
        
        // Comment this line when API is integrated.
        AppConstant.sceneDelegate?.setFlowAfterLogin()
    }
    
    
    @IBAction func didTapCreateAccountButton(_ sender: Any) {
        self.pushViewController(with: .main, viewcontroller: "RegisterViewController")
    }
    
}
