//
//  BaseButton.swift
//  IOSSwift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// UIButton class to manage different UI need for button which is not available default
class BaseButton: UIButton {
    
    @IBInspectable
    var textStyleValue: Int = TextStyle.none.value {
        didSet {
            self.applyFontTextStyle()
        }
    }
    
    var textStyle: TextStyle {
        if self.textStyleValue == TextStyle.largeTitle.value {
            return .largeTitle
        } else if self.textStyleValue == TextStyle.title1.value {
            return .title1
        } else if self.textStyleValue == TextStyle.title2.value {
            return .title2
        } else if self.textStyleValue == TextStyle.title3.value {
            return .title3
        } else if self.textStyleValue == TextStyle.headline.value {
            return .headline
        } else if self.textStyleValue == TextStyle.body.value {
            return .body
        } else if self.textStyleValue == TextStyle.callout.value {
            return .callout
        } else if self.textStyleValue == TextStyle.subheadline.value {
            return .subheadline
        } else if self.textStyleValue == TextStyle.footnote.value {
            return .footnote
        } else if self.textStyleValue == TextStyle.caption1.value {
            return .caption1
        } else if self.textStyleValue == TextStyle.caption2.value {
            return .caption2
        }
        return .none
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {}
    
    /**
     Base class function to set font for control
     */
    func setFont(_ fontEnum: UIFont.Font) {
        self.titleLabel?.font = UIFont.font(fontEnum, fontSize: self.titleLabel?.font.pointSize ?? 15)
        self.applyFontTextStyle()
    }
    
    /**
     Base class function to set font text style for control
     */
    func applyFontTextStyle() {
        if self.textStyle != .none {
            self.titleLabel?.font = self.titleLabel?.font.getFontTextStyled(self.textStyle.textStyle)
            self.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    
}

