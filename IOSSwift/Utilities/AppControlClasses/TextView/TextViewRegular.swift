//
//  TextViewRegular.swift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// Child class of BaseTextView which is used to set textview regular font
class TextViewRegular: BaseTextView {
    
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
        self.setFont(UIFont.Font.OpenSansRegular)
    }
    
}
