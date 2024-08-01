//
//  ViewExtensions.swift
//  IOSSwift
//
//  Created by CrestAdmin on 23/07/24.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.applyCornerRadius(radius: newValue)
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return (self.layer.borderColor != nil) ? UIColor.init(cgColor: self.layer.borderColor!) : nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    /**
     Method to apply corner radius to view
     - parameter radius: Represent radius value
     */
    func applyCornerRadius(radius: CGFloat = 8) {
        if radius > 0 {
            self.clipsToBounds = true
        }
        self.layer.cornerRadius = radius
    }
    
    /**
     Method to remove corner radius from view
     */
    func removeCornerRadius() {
        self.layer.cornerRadius = 0
        self.clipsToBounds = false
    }
    
    /**
     Method to make view round
     - parameter radius: Represent radius value
     */
    func roundView() {
        self.applyCornerRadius(radius: self.bounds.height / 2)
    }
    
    /**
     Method to apply border to view
     - parameter borderWidth: Represent border width value
     - parameter borderColor: Represent border color value
     */
    func applyBorder(_ borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.black) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    /**
     Method to remove border from view
     */
    func removeBorder() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    /**
     Method to apply shadow to view
     - parameter color: Represent shadow color
     - parameter offSetSize: Represent shadow offset, defaulr is .zero
     - parameter opacity: Represent opacity value, default is 1
     - parameter radius: Represent radius value, default is 4
     */
    func applyShadow(withColor color: UIColor, offSetSize: CGSize = CGSize.zero, opacity: Float = 1, radius: CGFloat = 4) {
        self.clipsToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offSetSize
        self.layer.masksToBounds = false
    }
    
    /**
     Method to apply shadow with corner radius to view
     - parameter cornerRadius: Represent shadow corner radius
     - parameter color: Represent shadow color
     - parameter offSetSize: Represent shadow offset, defaulr is .zero
     - parameter opacity: Represent opacity value, default is 1
     - parameter radius: Represent radius value, default is 4
     */
    func applyShadowWithCornerRadius(_ cornerRadius: CGFloat = 8, color: UIColor, offSetSize: CGSize = CGSize.zero, opacity: Float = 1, radius: CGFloat = 8) {
        self.clipsToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offSetSize
    }
    
    /**
     Method to apply shadow with bounce to view
     - parameter bounds: Represent bound frame
     - parameter color: Represent shadow color
     - parameter offSetSize: Represent shadow offset, defaulr is .zero
     - parameter opacity: Represent opacity value, default is 1
     - parameter radius: Represent radius value, default is 4
     */
    func applyShadowWithBounds(_ bounds: CGRect, color: UIColor, offSetSize: CGSize = CGSize.zero, opacity: Float = 1, radius: CGFloat = 4) {
        self.clipsToBounds = false
        let shadowPath = UIBezierPath.init(rect: bounds).cgPath
        self.layer.shadowPath = shadowPath
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offSetSize
        self.layer.masksToBounds = false
    }
    
    /**
     Method to apply dashed border to view
     - parameter borderWidth: Represent border width
     - parameter borderColor: Represent border color, by default black
     - parameter cornerRadius: Represent corner radius, by default is 0
     */
    func applyDashedBorder(_ borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.black, cornerRadius: CGFloat = 0) {
        
        self.layoutIfNeeded()
        if self.layer.sublayers?.count ?? 0 > 0 {
            let dashedBorderLayer = self.layer.sublayers!.filter({$0 is CAShapeLayer && $0.accessibilityHint == "dashedBorderLayer"}).first
            dashedBorderLayer?.removeFromSuperlayer()
        }
        
        let dashedBorderLayer = CAShapeLayer()
        dashedBorderLayer.accessibilityHint = "dashedBorderLayer"
        dashedBorderLayer.strokeColor = borderColor.cgColor
        dashedBorderLayer.lineDashPattern = [6, 2]
        dashedBorderLayer.frame = self.bounds
        dashedBorderLayer.fillColor = nil
        if cornerRadius > 0 {
            dashedBorderLayer.path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashedBorderLayer.path = UIBezierPath(rect: self.bounds).cgPath
        }
        self.layer.addSublayer(dashedBorderLayer)
        
    }
    
    /**
     Method to apply shadow to botton right-left corner of a view
     - parameter cornerRadius: Represent corner radius, by default is 0
     - parameter color: Represents shadow color
     */
    func applyBottomRightLeftCornerWithShadow(_ cornerRadius: CGFloat = 10, color: UIColor) {
        
        self.layoutIfNeeded()
        if self.layer.sublayers?.count ?? 0 > 0 {
            let shadowLayer = self.layer.sublayers!.filter({$0 is CAShapeLayer && $0.accessibilityHint == "shadowLayer"}).first
            shadowLayer?.removeFromSuperlayer()
        }
        
        self.clipsToBounds = false
        
        let shadowLayer = CAShapeLayer()
        let shadowBounds = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        let shadowPath = UIBezierPath(roundedRect: shadowBounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        shadowLayer.accessibilityHint = "shadowLayer"
        shadowLayer.path = shadowPath.cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        
        let shadowRadius = cornerRadius / 4
        
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: shadowRadius + 2)
        shadowLayer.shadowOpacity = 1.0
        shadowLayer.shadowRadius = shadowRadius
        
        self.layer.insertSublayer(shadowLayer, at: 0)
        
    }
    
    /**
     Method to load view from nib having discarsableResult attribute
     - returns UIView
     */
    @discardableResult
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /**
     Method to load xib
     */
    func loadXib() {
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
    }
    
}

extension UITapGestureRecognizer {
    
    /**
     Method to handle label tap
     - parameter label: Represent UILabel
     - parameter targetRange: Represent touch range
     - returns Bool
     */
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint.init(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint.init(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y);
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
        
    }
    
}
