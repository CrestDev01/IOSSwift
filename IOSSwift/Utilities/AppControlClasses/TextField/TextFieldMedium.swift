//
//  TextFieldMedium.swift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// Child class of BaseTextField which is used for textfield medium font
class TextFieldMedium: BaseTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Inherited method which is used for common init
     */
    override func commonInit() {
        self.setFont(UIFont.Font.OpenSansMedium)
    }
    
}
