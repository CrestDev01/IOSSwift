//
//  UserDefaultsExtension.swift
//  IOSSwift
//
//  Created by CrestAdmin on 30/07/24.
//

import Foundation

/// User default extension which contains custom functions to use userdefault feature
extension UserDefaults {
    
    enum ObjectSavableError: String, LocalizedError {
        case unableToEncode = "Unable to encode object into data"
        case noValue = "No data object found for the given key"
        case unableToDecode = "Unable to decode object into given type"
        
        var errorDescription: String? {
            rawValue
        }
    }
    
    /**
     Class method to save any object with key
     - parameter Object: Represent object to save of type any
     - parameter forKey: Represent String
     */
    
    func saveObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    /**
     Class method to get any object with key
     - parameter Object: Represent object to save of type any
     - parameter forKey: Represent String
     */
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
    /**
     Class method to get dictionary object for key from userdefaults
     - parameter key: Represent String
     - returns Dictonaty, optional type
     */
    class func getDictionary(forKey key: String) -> [String: Any]? {
        let value = UserDefaults.standard.dictionary(forKey: key)
        return value
    }
    
    /**
     Class method to save string for key in userdefaults
     - parameter value: Represent value to store
     - parameter key: Represent String
     */
    class func saveString(_ value: String?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Class method to get saved string for key from userdefaults
     - parameter key: Represent String
     - returns String
     */
    class func getString(forKey key: String) -> String? {
        let value = UserDefaults.standard.string(forKey: key)
        return value
    }
    
    /**
     Class method to save int value for key in userdefaults
     - parameter value: Represent value to store
     - parameter key: Represent String
     */
    class func saveInt(_ value: Int?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Class method to get saved int value for key from userdefaults
     - parameter key: Represent String
     - returns Int
     */
    class func getInt(forKey key: String) -> Int {
        let value = UserDefaults.standard.integer(forKey: key)
        return value
    }
    
    /**
     Class method to save float value for key in userdefaults
     - parameter value: Represent value to store
     - parameter key: Represent String
     */
    class func saveFloat(_ value: Float?, forKey key: String) {
        UserDefaults.standard.set(value ?? 0, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Class method to get float value for key from userdefaults
     - parameter key: Represent String
     - returns Float
     */
    class func getFloat(forKey key: String) -> Float {
        let value = UserDefaults.standard.float(forKey: key)
        return value
    }
    
    /**
     Class method to save double value for key in userdefaults
     - parameter value: Represent value to store
     - parameter key: Represent String
     */
    class func saveDouble(_ value: Double?, forKey key: String) {
        UserDefaults.standard.set(value ?? 0, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Class method to get double value for key from userdefaults
     - parameter key: Represent String
     - returns double
     */
    class func getDouble(forKey key: String) -> Double {
        let value = UserDefaults.standard.double(forKey: key)
        return value
    }
    
    /**
     Class method to save bool value for key in userdefaults
     - parameter value: Represent value to store
     - parameter key: Represent String
     */
    class func saveBool(_ value: Bool?, forKey key: String) {
        UserDefaults.standard.set(value ?? false, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Class method to get bool value for key from userdefaults
     - parameter key: Represent String
     - returns Bool
     */
    class func getBool(forKey key: String) -> Bool {
        let value = UserDefaults.standard.bool(forKey: key)
        return value
    }
    
    /**
     Class method to save Array object for key in userdefaults
     - parameter value: Represent value to store
     - parameter key: Represent String
     */
    class func saveArray(_ value: [Any]?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /**
     Class method to get array object for key from userdefaults
     - parameter key: Represent String
     - returns Array of type any, optional type
     */
    class func getArray(forKey key: String) -> [Any]? {
        let value = UserDefaults.standard.array(forKey: key)
        return value
    }
    
    /**
     Class method remove any object from userdefaults for specified key
     - parameter key: Represent String
     - returns Float
     */
    class func removeObject(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
