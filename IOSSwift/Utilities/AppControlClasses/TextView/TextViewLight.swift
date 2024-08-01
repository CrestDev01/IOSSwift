//
//  TextViewLight.swift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// Child class of BaseTextView which is used for textview light font
class TextViewLight: BaseTextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /**
     Inherited method which is used for common init
     */
    override func commonInit() {
        self.setFont(UIFont.Font.OpenSansLight)
    }
    
}
