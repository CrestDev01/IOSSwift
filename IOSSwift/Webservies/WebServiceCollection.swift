//
//  WebServiceCollection.swift
//  IOSSwift
//
//  Created by CrestAdmin on 29/07/24.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD
import BRYXBanner
import UIKit
import Alamofire

class WebServicesCollection
{
    static let sharedInstance = WebServicesCollection()
    private lazy var apiInstance: Repository = {
        return RepositoryImpl()
    }()
    // METHODS
    init() {}
}
//MARK:- Banner
extension WebServicesCollection
{
    func showInternetBanner()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let banner = Banner(title: InternetNotAvailable, subtitle: InternetNotAvailable, image: nil, backgroundColor: CustomColors.color_errorRedColor)
            banner.textColor = UIColor.black
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
        }
        
    }
   
    func showMessageBanner(info: String, error: Bool = false)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var color = UIColor()
            var img : UIImage!
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

extension WebServicesCollection{
    
    func API_LoginUser(param:[String: Any], completion: @escaping ((Bool, LoginModel?)->())){
        
        if ReachabilityManager.sharedInstance.isReachable()
        {
            SVProgressHUD.show()
            apiInstance.loginUser(param: param, method: .post)  { result in
                SVProgressHUD.dismiss()
                switch result{
                    
                case .Success(let response):
                    if response.isValid(){
                        self.showMessageBanner(info: response.message ?? ActionPerformedSuccessfully, error: false)
                        completion(true, response.data)
                    }
                    else{
                        self.showMessageBanner(info: response.message ?? SomethingWentWrong, error: true)
                        completion(false, nil)
                    }
                    
                case .GenericError(_, let error):
                    self.showMessageBanner(info: error.message, error: true)
                    completion(false, nil)
                case .NetworkError:
                    self.showMessageBanner(info: RequestTimeouut, error: true)
                    completion(false, nil)
                }
            
            }
        }
        else{
            self.showMessageBanner(info: InternetNotAvailable, error: true)
            completion(false, nil)
        }
    }
    
    
    func API_RegisterUser(param:[String: Any], completion: @escaping ((Bool, RegisterModel?)->())){
        
        if ReachabilityManager.sharedInstance.isReachable()
        {
            SVProgressHUD.show()
            apiInstance.registerUser(param: param, method: .post) { result in
                SVProgressHUD.dismiss()
                switch result{
                    
                case .Success(let response):
                    if response.isValid(){
                        self.showMessageBanner(info: response.message ?? ActionPerformedSuccessfully, error: false)
                        completion(true, response.data)
                    }
                    else{
                        self.showMessageBanner(info: response.message ?? SomethingWentWrong, error: true)
                        completion(false, nil)
                    }
                    
                case .GenericError(_, let error):
                    self.showMessageBanner(info: error.message, error: true)
                    completion(false, nil)
                case .NetworkError:
                    self.showMessageBanner(info: RequestTimeouut, error: true)
                    completion(false, nil)
                }
            
            }
        }
        else{
            self.showMessageBanner(info: InternetNotAvailable, error: true)
            completion(false, nil)
        }
    }
    
    func API_AddJob(param:[String: Any], completion: @escaping ((Bool, RegisterModel?)->())){
        
        if ReachabilityManager.sharedInstance.isReachable()
        {
            SVProgressHUD.show()
            apiInstance.addJob(param: param, token: AppConstant.sceneDelegate?.token ?? "", method: .post)  { result in
                SVProgressHUD.dismiss()
                switch result{
                    
                case .Success(let response):
                    if response.isValid(){
                        self.showMessageBanner(info: response.message ?? ActionPerformedSuccessfully, error: false)
                        completion(true, response.data)
                    }
                    else{
                        self.showMessageBanner(info: response.message ?? SomethingWentWrong, error: true)
                        completion(false, nil)
                    }
                    
                case .GenericError(_, let error):
                    self.showMessageBanner(info: error.message, error: true)
                    completion(false, nil)
                case .NetworkError:
                    self.showMessageBanner(info: RequestTimeouut, error: true)
                    completion(false, nil)
                }
            
            }
        }
        else{
            self.showMessageBanner(info: InternetNotAvailable, error: true)
            completion(false, nil)
        }
    }
    
    func API_UserDetails(completion: @escaping ((Bool, UserModel?)->())){
        
        if ReachabilityManager.sharedInstance.isReachable()
        {
            SVProgressHUD.show()
            
            apiInstance.getUserProfile(token:AppConstant.sceneDelegate?.token ?? "" , method: .get)  { result in
                SVProgressHUD.dismiss()
                switch result{
                    
                case .Success(let response):
                    if response.isValid(){
                        completion(true, response.data)
                    }
                    else{
                        completion(false, nil)
                    }
                    
                case .GenericError(_, let error):
                    self.showMessageBanner(info: error.message, error: true)
                    completion(false, nil)
                case .NetworkError:
                    self.showMessageBanner(info: InternetNotAvailable, error: true)
                    completion(false, nil)
                }
            
            }
        }
        else{
            self.showMessageBanner(info: InternetNotAvailable, error: true)
            completion(false, nil)
        }
    }
    

    
}
