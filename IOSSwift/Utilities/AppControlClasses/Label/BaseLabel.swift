//
//  BaseLabel.swift
//
// Created by CrestAdmin on 25/07/24.
//

import UIKit

/// UILabel class to manage different UI need for button which is not available default
class BaseLabel: UILabel {
    
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
    
    fileprivate var tappableCompletion: ((UILabel, String)->())?
    
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
     Method to set custom font
     - parameter fontEnum: Enum defined in UIFont extension
     
     */
    func setFont(_ fontEnum: UIFont.Font) {
        self.font = UIFont.font(fontEnum, fontSize: self.font.pointSize)
        self.applyFontTextStyle()
    }
    
    /**
     Method to apply font text style
     */
    func applyFontTextStyle() {
        if self.textStyle != .none {
            self.font = self.font.getFontTextStyled(self.textStyle.textStyle)
            self.adjustsFontForContentSizeCategory = true
        }
    }
    
}

extension BaseLabel {
    
    
    
    /**
     Method to make label tappable
    - parameter text: Represnt label text
    - parameter completion: Completion block which returns label and text
     */
    
    func makeTappable(for text: String, completion: ((UILabel, String)->())?) {
        self.tappableCompletion = completion
        self.gestureRecognizers?.removeAll()
        self.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didTapLabel(_:)))
        tapGestureRecognizer.accessibilityHint = text
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /**
     Method to handle label tap action
     - parameter sender: Represents gesture from label
     */
    
    @IBAction fileprivate func didTapLabel(_ sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel, let tappableTexts = sender.accessibilityHint {
            let arrayTappableTexts = tappableTexts.components(separatedBy: ", ")
            arrayTappableTexts.forEach { (tappableText) in
                if let range = (self.text as NSString?)?.range(of: tappableText) {
                    if sender.didTapAttributedTextInLabel(label: label, inRange: range) {
                        self.tappableCompletion?(label, tappableText)
                    }
                }
            }
        }
    }
    
}

extension BaseLabel {
    
    /**
     Method to mark label as compulsory title with red asterisk symbol
     - parameter string: Represents text for label
     - parameter primaryColor: Represents color for label
     
     */
    func setAsterisk(on string: String?, primaryColor: UIColor = .blue) {
        let attributedString = NSMutableAttributedString.init(string: (string ?? ""), attributes: [.foregroundColor : primaryColor])
        if !((string ?? "").contains("*")) {
            let asteriskAttributedString = NSMutableAttributedString.init(string: " *", attributes: [.font: self.font as Any, .foregroundColor : UIColor.red])
            attributedString.append(asteriskAttributedString)
        }
        self.attributedText = attributedString
    }
    
}
