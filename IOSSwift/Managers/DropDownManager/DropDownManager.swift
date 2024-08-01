//
//  DropDownManager.swift
//  IOSSwift
//
//  Created by Crest Infosystems on 18/07/19.
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import UIKit
import DropDown

class DropDownManager: NSObject {
    
    static let shared: DropDownManager = {
        let instance = DropDownManager.init()
        instance.commonInit()
        return instance
    }()
    
    var dropDown = DropDown.init()
    
    fileprivate var tuple: (arrayIndexes: [Int], arrayItems: [String]) = ([],[])
    
    fileprivate func commonInit() {
        
        // Basic setup
        let appearance = DropDown.appearance()
        appearance.cellHeight = 40
        appearance.backgroundColor = CustomColors.color_lightGrayColor
        appearance.selectionBackgroundColor = CustomColors.color_blueColor
        appearance.textColor = UIColor.black
        appearance.selectedTextColor = UIColor.black
        appearance.shadowOpacity = 0
        
        self.dropDown.cellNib = UINib(nibName: String(describing: SimpleDropDownCellView.self), bundle: nil)
        self.dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? SimpleDropDownCellView else { return }
            
            // Setup your custom UI components
            cell.optionLabel.text = item
        }
        
        self.dropDown.dismissMode = .onTap
        self.dropDown.direction = .any
        
    }
    
}

extension DropDownManager {
    
    /**
     Method to add dropdown
     - parameter button: Represent sender
     - parameter dataSource: Represents array of string
     - parameter isMultiSelect: Represents boolean value for multi select, by default false
     - parameter maxAllowedSelection: Represent max allowed selection
     - parameter preselectedIndexes: Represent row index to show selection
     - parameter selectionCompletion: Callback block for selection completion, by default nil
     - parameter multiSelectionCompletion: Callback block for multi selection, by default nil
     */
    func addDropDown(onButton button: UIButton, dataSource: [String], isMultiSelect: Bool = false, maxAllowedSelection: Int = 0, preselectedIndexes: [Int] = [0], selectionCompletion: ((Int, String)->())? = nil, multiSelectionCompletion: (([Int], [String])->())? = nil) {
        
        self.dropDown.anchorView = button
        self.dropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        
        self.dropDown.dataSource = dataSource
        
        if isMultiSelect == true {
            self.dropDown.selectionAction = nil
            var selectedValues: [String] = []
            preselectedIndexes.forEach { (index) in
                selectedValues.append(dataSource[index])
            }
            self.tuple = (preselectedIndexes, selectedValues)
            self.dropDown.selectRows(at: Set.init(preselectedIndexes))
            self.dropDown.multiSelectionAction = { (arrayIndex, arrayItem) in
                if maxAllowedSelection > 0 && arrayIndex.count > maxAllowedSelection {
                    let message = "\(maximum) \(maxAllowedSelection) \(itemsAllowed)"
                    if let presentedController = GeneralUtility.currentViewController?.presentedViewController {
                        presentedController.showToastMessageBanner(info: message, error: true)
                    } else {
                        GeneralUtility.currentViewController?.showToastMessageBanner(info: message, error: true)
                    }
                    let index = Set(arrayIndex).subtracting(self.tuple.arrayIndexes).first
                    self.dropDown.deselectRow(at: index)
                    self.dropDown.reloadAllComponents()
                } else {
                    self.tuple = (arrayIndexes: arrayIndex, arrayItems: arrayItem)
                }
            }
            self.dropDown.cancelAction = {
                multiSelectionCompletion?(self.tuple.arrayIndexes, self.tuple.arrayItems)
            }
            
        } else {
            self.dropDown.multiSelectionAction = nil
            self.dropDown.cancelAction = nil
            self.dropDown.selectRow(at: preselectedIndexes.first ?? 0)
            selectionCompletion?(preselectedIndexes.first ?? 0, dataSource[preselectedIndexes.first ?? 0])
            self.dropDown.selectionAction = { (index, item) in
                selectionCompletion?(index, item)
            }
        }
        
    }
    
    /**
     Method to show dropdown
     */
    func showDropDown() {
        self.dropDown.show()
    }
    
}

