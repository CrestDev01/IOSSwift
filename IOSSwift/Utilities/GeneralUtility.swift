//
//  GeneralUtility.swift
//  CoreIndustry
//
//  Created by Crest Infosystems on 26/09/19.
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

struct GeneralUtility {
    
    typealias EmptyClosure = (()->())
    typealias BooleanClosure = ((Bool)->())
 
    
    static var currentViewController: UIViewController? {
        var currentVC: UIViewController?
        let rootVC = AppConstant.sceneDelegate?.window?.rootViewController
        if let navController = rootVC as? UINavigationController  {
            currentVC = navController.topViewController
        } else {
            currentVC = rootVC
        }
        if let tabBarController = currentVC as? MainTabBarViewController {
            currentVC = tabBarController.selectedViewController
            if let navController = currentVC as? UINavigationController  {
                currentVC = navController.topViewController
            }
        }
        return currentVC
    }
    
    static var fileManager: FileManager = {
        let manager = FileManager.default
        return manager
    }()
    
}



extension GeneralUtility {
    
    /**
     Method to show alert view with some message on screen
     - parameter vc: Represent viewcontroller to show alert
     - parameter title: Represent title text for alert
     - parameter message: Represent message to show in alert
     - parameter actions: Represent array of action buttons to add in alert eg. OK , Cancle etc
     - parameter defaultButtonAction: Represent callback block for default action button, by default nil
     */
    static func showAlert(onVC vc: UIViewController?, withTitle title: String? = nil, message: String, actions:[UIAlertAction] = [], defaultButtonAction:(()->())? = nil) {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if actions.count > 0 {
            for action in actions {
                alertController.addAction(action)
            }
        } else {
            let action = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default) { (alertAction) in
                defaultButtonAction?()
            }
            alertController.addAction(action)
        }
        vc?.present(alertController, animated: true) {
        }
        
    }
    
}

extension GeneralUtility {
    
    /**
     Method to get document diectory path
     - returns String
     */
    static func documentDirectoryPath() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        return documentDirectory!
    }
    
    /**
     Method to get download directory path and create Downloads directory if not present
     - returns String
     */
    static func downloadDirectoryPath() -> String {
        let documentDirectory = GeneralUtility.documentDirectoryPath()
        let downloadDirectory = documentDirectory.appending("/Downloads")
        if !(GeneralUtility.fileManager.fileExists(atPath: downloadDirectory)) {
            do {
                try GeneralUtility.fileManager.createDirectory(atPath: downloadDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory: \(error)")
            }
        }
        return downloadDirectory
    }
    
    /**
     Method to get image directory path and create Images directory if not present
      */
    static func imageDirectoryPath() -> String {
        let documentDirectory = GeneralUtility.documentDirectoryPath()
        let imageDirectory = documentDirectory.appending("/Images")
        if !(GeneralUtility.fileManager.fileExists(atPath: imageDirectory)) {
            do {
                try GeneralUtility.fileManager.createDirectory(atPath: imageDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory: \(error)")
            }
        }
        return imageDirectory
    }
    
    /**
     Method to delete file from directory path
     - parameter url: Represent path URL string from file to delete
     - parameter completion: Represent callback for delete completion
     */
    static func deleteFile(at url: URL, completion: ((Bool, String)->())) {
        if GeneralUtility.fileManager.fileExists(atPath: url.path) {
            do {
                try GeneralUtility.fileManager.removeItem(at: url)
                completion(true, "")
            } catch {
                print("Error ---- \(error)")
                completion(false, error.localizedDescription)
            }
        }
    }
    
    /**
     Method to delete file from directory path with specified extension
     - parameter url: Represent path URL string from file to delete
     - parameter ext: Represent file extension
     - parameter completion: Represent callback for delete completion
     */
    static func deleteFile(at url: URL, withExtension ext: String, completion: ((Bool, String)->())) {
        let finalURL = url.appendingPathExtension(ext)
        if GeneralUtility.fileManager.fileExists(atPath: finalURL.path) {
            do {
                try GeneralUtility.fileManager.removeItem(at: finalURL)
                completion(true, "")
            } catch {
                print("Error ---- \(error)")
                completion(false, error.localizedDescription)
            }
        } else {
            completion(false, "File doesn't exists.")
        }
    }
    
    /**
     Method to generate unique file name
     - returns String
      */
    static func getUniqueFilename() -> String {
        let uniqueName = Date.stringDate(fromDate: Date.init(), dateFormat: DateFormat.uniqueString)
        return uniqueName!
    }
    
}

extension GeneralUtility {
    
    /**
     Validation method to check non empty string
     - parameter text: Represent text to validate
     - parameter includingSpace: Represent bool value to indicate string contains space
     - returns Bool
     */
    static func isNonEmptyString(_ text: String?, includingSpace: Bool = false) -> Bool {
        if includingSpace == true {
            return (text?.trimmed().count ?? 0) > 0
        }
        return (text?.count ?? 0) > 0
    }
    
    /**
     Validation method to check vslid password length
     - parameter text: Represent text to validate
     - returns Bool
     */
    static func isValidPasswordLength(_ text: String?) -> Bool{
        return (text?.count ?? 0) >= 5
    }
    
    /**
     Validation method to check valid email
     - parameter email: Represent text to validate
     - returns Bool
     */
    static func isValidEmail(_ email: String?) -> Bool {
        if (email?.count ?? 0) > 0 {
            let regexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            do {
                let regex = try NSRegularExpression.init(pattern: regexPattern, options: NSRegularExpression.Options.caseInsensitive)
                let regexMatches = regex.numberOfMatches(in: email!, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange.init(location: 0, length: email!.count))
                if regexMatches == 0 {
                    return false
                } else {
                    return true
                }
            } catch {
                print(error)
            }
        }
        return false
    }
    
    
    /**
     Validation method to check gift card number
     - parameter string: Represent text to validate
     - returns Bool
     */
    static func isValidGiftCardNumber(string : String)->Bool{
        do{
            let regex = try NSRegularExpression(pattern: "^[0-9-.$/%+ ]+$", options: .caseInsensitive)
            let range = NSRange(string.startIndex..., in: string)
            let matchRange = regex.rangeOfFirstMatch(in: string, options: .reportProgress, range: range)
            return matchRange.location != NSNotFound
        }
        catch{
            print("error")
            return false
        }
        
    }
}
