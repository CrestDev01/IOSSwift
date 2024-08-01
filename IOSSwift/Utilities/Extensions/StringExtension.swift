//
//  StringExtension.swift
//  CoreIndustry
//
//  Created by Crest Infosystems on 16/07/19.
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     Method to modify encodeURL
     */
    mutating func encodeURL() {
        self = self.encodedURL()
    }
    
    /**
     Method to modify decodeURL
     */
    mutating func decodeURL() {
        self = self.decodedURL()
    }
    
    /**
     Method to modify encodeURLQuery
     */
    mutating func encodeURLQuery() {
        self = self.encodedURLQuery()
    }
    
    /**
     Method to return encodedURL string
     - returns encoded url string
     */
    func encodedURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? self
    }
    
    /**
     Method to return decodedURL string
     - returns decoded url string
     */
    func decodedURL() -> String {
        return self.removingPercentEncoding ?? self
    }
    
    /**
     Method to return encoded URL Query string
     - returns url string
     */
    func encodedURLQuery() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? self
    }
    
    /**
     Method to convert Data to base64 String
     - parameter data: Represent data
     - returns string
     */
    static func base64Encode(_ data: Data?) -> String {
        if data != nil {
            return data!.base64EncodedString()
        }
        return ""
    }
    
    /**
     Method to convert UIImage to base64 String
     - parameter image: Represent image
     - returns string
     */
    static func base64Encode(_ image: UIImage) -> String {
        let data = image.pngData()
        return String.base64Encode(data)
    }
    
    /**
     Method to convert file to base64 String
     - parameter filepath: Represent filepath string
     - returns string
     */
    static func base64Encode(_ filepath: String) -> String {
        do {
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: filepath))
            return String.base64Encode(data)
        } catch let error {
            print(error)
        }
        return ""
    }
    
    /**
     Method to convert string to UTF8 data
     - returns Data
     */
    func utf8Encoded() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
    
    /**
     Method to modify string with base 64 encoded string
     */
    mutating func encodeBase64() {
        self = self.utf8Encoded().base64EncodedString()
    }
    
    /**
     Method to get encoded base 64 string
     - returns String
     */
    func encodedBase64() -> String {
        return self.utf8Encoded().base64EncodedString()
    }
    
    /**
     Method to modify string with decoded base 64 string
     */
    mutating func decodeBase64() {
        self = self.decodedBase64()
    }
    
    /**
     Method to get decoded utf8 string
     - returns String
     */
    func decodedBase64() -> String {
        if let decodedData = Data.init(base64Encoded: self) {
            return String.init(data: decodedData, encoding: String.Encoding.utf8) ?? self
        }
        return self
    }
    
    /**
     Method to get trim white space and new line from string
     - returns String
     */
    func trimmed() -> String {
        let whitespace = CharacterSet.whitespacesAndNewlines
        let stringTrimmed = self.trimmingCharacters(in: whitespace)
        let stringWithoutSpace = stringTrimmed.replacingOccurrences(of: " ", with: "")
        return stringWithoutSpace
    }
    
    /**
     Method to modify set with trimmed string
     */
    mutating func trim() {
        self = self.trimmed()
    }
    
    /**
     Method to get string value to int
     - returns Int
     */
    func toInt() -> Int {
        let intValue = Int(self)
        return intValue ?? 0
    }
    
    /**
     Method to get double value from string
     - returns doouble
     */
    func toDouble() -> Double {
        return Double.numberFormatter.number(from: self)?.doubleValue ?? 0
    }
    
    /**
     Method to get string width
     - returns CGFloat
     */
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    /**
     Method to get string height
     - returns CGFloat
     */
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    /**
     Method to change normal text appearance to hyperlink appearance
     - returns NSAttributedString
     */
    func getHyperlinkText(isLink: Bool) -> NSAttributedString{
        let color = isLink ? CustomColors.color_blueColor : UIColor.blue
        let attributedText = NSMutableAttributedString(string: self)
        let textRange = NSMakeRange(0, self.count)
        if isLink{
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        }
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor , value: color, range: textRange)
        return attributedText

    }
    
    /**
     Method to get URL from string
     - returns URL
     */
    func toURL() -> URL? {
        let url = URL.init(string: self)
        return url
    }
    
    /**
     Method to modify string with encoded url last path component
     */
    mutating func encodeURLLastPathComponent() {
        var arrayComponents = self.components(separatedBy: "/")
        let lastComponent = arrayComponents.popLast() ?? ""
        arrayComponents.append(lastComponent.encodedURL())
        self = arrayComponents.joined(separator: "/")
    }
    
    /**
     Method to get encoded url last path component
     - returns String
     */
    func encodedURLLastPathComponent() -> String {
        var arrayComponents = self.components(separatedBy: "/")
        let lastComponent = arrayComponents.popLast() ?? ""
        arrayComponents.append(lastComponent.encodedURL())
        return arrayComponents.joined(separator: "/")
    }
    
    /**
     Method to get formatter string with currency
     - returns String
     */
    static func currenyString(fromDouble value: Double?) -> String {
        if value == nil {
            return ""
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        if let string = numberFormatter.string(from: NSNumber.init(value: value!)) {
            return string
        }
        return ""
    }
    
    /**
     Method to currently string to double
     - returns Double
     */
    func currencyToDouble() -> Double {
        if self.count <= 0 {
            return 0
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        let number = numberFormatter.number(from: self)
        return number?.doubleValue ?? 0
    }
    
    /**
     Method to currently double value to String
     - returns String
     */
    static func fromDouble(_ value: Double?) -> String {
        if value == nil {
            return ""
        }
        return "\(value!)"
    }
    
    /**
     Method to format phone number string
     - parameter phoneNumber: Represnts phone number value in string
     - parameter shouldRemoveLastDigit: Represnts boolean value to remove last digit
     - returns String
     */
    static func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        }
        
        return number
        
    }
    
//    var localized: String {
//        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
//    }
//    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attributedString
        } catch {
            return nil
        }
    }
    
}

extension Double {
    
    static var numberFormatter: NumberFormatter = {
        let tempNumberFormatter = NumberFormatter.init()
        tempNumberFormatter.numberStyle = .decimal
        return tempNumberFormatter
    }()
    
    var string: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    /**
     Method to round double value
     - returns Double
     */
    func round(upto: Int) -> Double {
        Double.numberFormatter.maximumFractionDigits = upto
        Double.numberFormatter.roundingMode = .halfUp
        let string = Double.numberFormatter.string(from: NSNumber.init(value: self))
        return string?.toDouble() ?? 0
    }
    
    /**
     Method to convert double to string with 2 digit after decimal
     - parameter upto: Represends number of digits after decimal
     - returns String
     */
    
    func toString(upto: Int = 2) -> String? {
        let string = String(format: "%.\(upto)f", self)
        return string
    }
    
    /**
     Method to format double type number to string with percentage
     - returns String
     */
    func toPercentageString() -> String? {
        let string = self.round(upto: 2).string + " %"
        return string
    }
    
    /**
     Method to get negative value of double
     - returns Double
     */
    func getNegativeValue() -> Double {
        if (self == -0 || self == 0) {
            return 0
        }
        if self > 0 {
            return (0 - self)
        }
        return self
    }
    
    /**
     Method to modify double type number to negative value
     */
    mutating func toNegativeValue() {
        self = self.getNegativeValue()
    }
    
    /**
     Method to get positive value of a double type number
     - returns Double
     */
    func getPositiveValue() -> Double {
        if (self == -0 || self == 0) {
            return 0
        }
        if self < 0 {
            return (0 - self)
        }
        return self
    }
    
    /**
     Method to modify double type number with positive string value
     - returns String
     */
    mutating func toPositiveValue() {
        self = self.getPositiveValue()
    }
    
}

extension Int {
    
    /**
     Method to get negative value to an integer number
     - returns Int
     */
    func getNegativeValue() -> Int {
        if (self == -0 || self == 0) {
            return 0
        }
        if self > 0 {
            return (0 - self)
        }
        return self
    }
    
    /**
     Method to modify integer number with negative value
     */
    mutating func toNegativeValue() {
        self = self.getNegativeValue()
    }
    
    /**
     Method to get positive value for integer number
     - returns Int
     */
    func getPositiveValue() -> Int {
        if (self == -0 || self == 0) {
            return 0
        }
        if self < 0 {
            return (0 - self)
        }
        return self
    }
    
    /**
     Method to modify Integer value with positive value
     - returns String
     */
    mutating func toPositiveValue() {
        self = self.getPositiveValue()
    }
    
}

/**
 Method to print any item for debug purpose
 - parameter items: Represents item to print
 - parameter separator: Represents separator
 - parameter terminator: Represents terminator
 */
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print(output, terminator: terminator)
    #endif
}
