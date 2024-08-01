//
//  RegisterViewController.swift
//  IOSSwift
//
//  Created by CrestAdmin on 25/07/24.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Enums
    enum fields{
        case profile
        case firstname
        case lastname
        case email
        case phone
        case password
        case confirm_password
        
        var title : String {
            switch self {
            case .firstname:
                return "First Name"
            case .lastname:
                return "Last Name"
            case .email:
                return "Email"
            case .password:
                return "Password"
            case .confirm_password:
                return "Confirm Password"
            case .phone:
                return "Phone number"
            default:
                return ""
            }
        }
        
        var key :String{
            switch self {
            case .profile:
                return "image"
            case .firstname:
                return "first_name"
            case .lastname:
                return "last_name"
            case .email:
                return "email"
            case .password:
                return "password"
            default:
                return ""
            
            }
        }
        
        var keyboardType: UIKeyboardType{
            switch self{
            case .phone:
                return .phonePad
            case .email:
                return .emailAddress
            default:
                return .default
            }
        }
        
        var isSecuredText: Bool{
            switch self{
                case .password:
                    return true
                case .confirm_password:
                    return true
                default:
                    return false
            }
        }
        
        var apiKey : String{
            switch self{
                case .profile:
                    return APIKeyImage
                case .firstname:
                    return APIKeyFirstname
                case .lastname:
                    return APIKeyLastname
                case .email:
                    return APIkeyEmail
                case .password:
                    return APIKeyPassword
                case .phone:
                    return APIkeyPhone
                default:
                    return ""
            }
        }
        
        var returnKeyType: UIReturnKeyType{
            switch self {
            case .confirm_password:
                return .done
            default:
                return .next
            }
        }
        
        var cellIdentifier : String{
            switch self{
            case .profile:
                return "profileCell"
            default:
                return "formCell"
            }
        }
    }
   
    //MARK: - Outlets
    @IBOutlet weak var registerTableView: UITableView!
    
    
    //MARK: - Properties
    var registrationFields : [fields] = [.profile, .firstname, .lastname, .email, .phone, .password, .confirm_password];
    var image: UIImage? {
        didSet {
            self.registerTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
       }
    }
    
    // added few static case to make the api work
    var paramDic = [
        APIkeyCountryCode : "+91",
        APIKeyDeviceID : "asdasdsadasda",
        APIKeyDeviceType : "1",
        APIKeySignupType : "0",
        APIKeyDob : "10-09-1992"
    
    ] as [String : Any]
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions

   @objc func didTapProfileImage(_ sender: UIButton) {
        ImagePickerManager.shared.presentUIImagePickerControllerSourceTypeActionSheet(on: sender, allowsEditing: true) { (image) in
            self.image = image ?? AppConstant.Image.common.image_profile
        }
    }
    
    @IBAction func didTapSignIn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSignUpButton(_ sender: Any) {
    
        /*
         /////  Uncomment to call API, apply validation before calling API
         WebServicesCollection.sharedInstance.API_RegisterUser(param: paramDic) { is_success, model in
            if(is_success){
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
         
         */
    }
}

//MARK: - TableView Management
extension RegisterViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrationFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowField = registrationFields[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rowField.cellIdentifier, for: indexPath) as! FormTableViewCell
        if(indexPath.row != 0){
            cell.titleLabel.text = rowField.title
            cell.textfield.isSecureTextEntry = rowField.isSecuredText
            cell.textfield.keyboardType = rowField.keyboardType
            cell.textfield.returnKeyType = rowField.returnKeyType
            cell.textfield.delegate = self
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            cell.textfield.text = paramDic[registrationFields[indexPath.row].apiKey] as? String ?? ""
        }
        else{
            
            cell.profileButton.addTarget(self, action: #selector(didTapProfileImage(_:)), for: .touchUpInside)
            cell.profileImage.image = image ?? AppConstant.Image.common.image_profile
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 100 :  80
    }
}

//MARK: - Textfield delegate
extension RegisterViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to:self.registerTableView)
        if let indexPath = self.registerTableView.indexPathForRow(at: buttonPosition){
            if indexPath.row == self.registrationFields.count - 1{
                self.view.endEditing(true)
            }
            else if let cell = self.registerTableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: 0)) as? FormTableViewCell{
                cell.textfield.becomeFirstResponder()
            }
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField){
        let buttonPosition:CGPoint = textfield.convert(CGPoint.zero, to:self.registerTableView)
        if let indexPath = self.registerTableView.indexPathForRow(at: buttonPosition){
            paramDic[registrationFields[indexPath.row].apiKey] = textfield.text
        }
    }
}
