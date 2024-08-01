//
//  LabelRegular.swift
//  IOSSwift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// Child class of BaseLabel which is used for UILabel regular font
class LabelRegular: BaseLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Common init function to inherit in child class
     */
    override func commonInit() {
        self.setFont(UIFont.Font.OpenSansRegular)
    }

}
