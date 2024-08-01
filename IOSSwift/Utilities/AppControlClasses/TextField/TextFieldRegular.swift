//
//  TextFieldRegular.swift
//
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import UIKit

/// Child class of BaseTextField which is used for textfield regular font
class TextFieldRegular: BaseTextField {
    
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
        self.setFont(UIFont.Font.OpenSansRegular)
    }
    
}
