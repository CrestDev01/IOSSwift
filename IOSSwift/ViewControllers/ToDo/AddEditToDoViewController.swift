//
//  AddToDoViewController.swift
//  IOSSwift
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation
import UIKit
import DropDown

class AddEditToDoViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryDropDownButton: UIButton!
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    // MARK: - Properties
    let categoryDropDown = DropDown()
    let categories = ["Personal", "Work"]
    var selectedCategoryIndex = 0
    var toDo: ToDoModel?{
        didSet{
            isEdit = true
        }
    }
    var isEdit : Bool?{
        didSet{
            self.prefillDataForEdit()
        }
    }
    
     
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = (self.isEdit ?? false) ? EditToDoTitle : AddToDoTitle
        self.setupCategoryDropdown()
        
        
    }
    
    // MARK: - Custom functions setup
    func setupCategoryDropdown(){
        self.categoryDropDown.anchorView = categoryDropDownButton
        self.categoryDropDown.bottomOffset = CGPoint(x: 0, y:(categoryDropDown.anchorView?.plainView.bounds.height)! + 10)
        self.categoryDropDown.backgroundColor = .white
        self.categoryDropDown.dataSource = categories
        self.categoryDropDownButton.setTitle(categories[selectedCategoryIndex], for: .normal)
        self.categoryDropDown.selectionAction = {  (index: Int, item: String) in
            self.selectedCategoryIndex = index
            self.categoryDropDownButton.setTitle(item, for: .normal)
        }
    }
    
    func prefillDataForEdit(){
       
        if(self.toDo != nil){
            self.titleTextField.text = self.toDo?.title ?? ""
            self.descriptionTextView.text = toDo?.description ?? ""
            
            // assuming category id same as index, apply filter if required
            self.selectedCategoryIndex = toDo?.categoryId ?? 0
            self.categoryDropDownButton.setTitle(categories[toDo?.categoryId ?? 0], for: .normal)
        }
    }
    // MARK: - Actions
    
    @IBAction func didTapCategoryDropDown(_ sender: Any) {
        categoryDropDown.show()
    }
    
    
    @IBAction func didTapAddJobButton(_ sender: Any) {
        
        let _ =  [
            APIKeyCategoryID: self.selectedCategoryIndex + 1, // fetch proper id for the selected category, this is tempory fix
            APIKeyUserID: AppConstant.sceneDelegate?.loginUser?.userId ?? 0,
            APIKeyTitle: titleTextField.text ?? "",
            APIKeyDescription : descriptionTextView.text ?? "",
        ] as [String : Any]
        
    /*
     
     /////  Uncomment to call API, apply validation before calling API
     
        WebServicesCollection.sharedInstance.API_AddJob(param: param ) { success, model in
            if(success){
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
     */
    }
    
}
