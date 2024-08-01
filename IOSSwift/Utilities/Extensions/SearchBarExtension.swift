//
//  SearchBarExtension.swift
//  IOSSwift
//
//  Created by Nikhil Patel on 10/10/19.
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {

    /**
     Method to get searchbar textfield
     - returns UITextField
     */
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    
    /**
     Method to set textfield text color
     - parameter textColor: Represent color for text
     */
    func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
    
    /**
     Method to set textfield placeholder and color
     - parameter textColor: Represent color for placeholder
     */
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    
    /**
     Method to set clear buttion to textfield
     - parameter color: Represent color for clear button
     */
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }

    /**
     Method to set textfield appearance
     - parameter color: Represent color
     */
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }

    /**
     Method to set search image
     - parameter color: Represent color for image
     */
    func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
}

private extension UITextField {

    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }

        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }


    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }

    /**
     Method to set clear button
     - parameter color: Represent tint color for image
     */
    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }

    /**
     Method to set place holder
     - parameter textColor: Represent placeholder text color 
     */
    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        placeholderLabel.removeFromSuperview()
        setValue(label, forKey: "placeholderLabel")
    }

    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
}
