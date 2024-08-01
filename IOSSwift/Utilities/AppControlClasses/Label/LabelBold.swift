//
//  LabelBold.swift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// Child class of BaseLabel which is used for UILabel bold font
class LabelBold: BaseLabel {
    
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
        self.setFont(UIFont.Font.OpenSansBold)
    }
    
}
