//
//  DateExtension.swift
//  IOSSwift
//
//  Created by Crest Infosystems on 16/07/19.
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import Foundation

enum DateFormat {
    
    case defaultDateTimeUS
    case defaultDateTimeUK
    case defaultDateUS
    case defaultDateUK
    case time24HrsWithSeconds
    case time24HrsWithoutSeconds
    case time12HrsWithSeconds
    case time12HrsWithoutSeconds
    case defaultDateTimeUK12HrsWithoutSeconds
    case MMMMdd
    case MMMdd
    case dd
    case monthNumeric1Digit
    case monthNumeric2Digits
    case year2Digits
    case year4Digits
    case yyyyMMddWithDash
    case uniqueString
    case EEE
    case EEEE
    case yyyyMMddHHmmssWithDashSpaceColon
    case yyyyMMddTHHmmssSSSZ //2019-07-23T11:49:46.000Z
    case MMddyyyy
    case yyyyMMdd
    case yyyyMMddHHmmss // Batch Close Format
    case userBased(String)
    
    var value: String {
        switch self {
            case .defaultDateTimeUS:                            return "MM-dd-yyyy HH:mm:ss"
            case .defaultDateTimeUK:                            return "dd-MM-yyyy HH:mm:ss"
            case .defaultDateUS:                                return "MM-dd-yyyy"
            case .defaultDateUK:                                return "dd-MM-yyyy"
            case .time24HrsWithSeconds:                         return "HH:mm:ss"
            case .time24HrsWithoutSeconds:                      return "HH:mm"
            case .time12HrsWithSeconds:                         return "hh:mm:ss a"
            case .time12HrsWithoutSeconds:                      return "hh:mm a"
            case .defaultDateTimeUK12HrsWithoutSeconds:         return "dd-MM-yyyy hh:mm a"
            case .MMMMdd:                                       return "MMMM dd"
            case .MMMdd:                                        return "MMM dd"
            case .dd:                                           return "dd"
            case .monthNumeric1Digit:                           return "M"
            case .monthNumeric2Digits:                          return "MM"
            case .year2Digits:                                  return "yy"
            case .year4Digits:                                  return "yyyy"
            case .yyyyMMddWithDash:                             return "yyyy-MM-dd"
            case .uniqueString:                                 return "ddMMyyyyHHmmssSSSS"
            case .EEE:                                          return "EEE"
            case .EEEE:                                         return "EEEE"
            case .yyyyMMddHHmmssWithDashSpaceColon:             return "yyyy-MM-dd HH:mm:ss"
            case .yyyyMMddTHHmmssSSSZ:                          return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            case .MMddyyyy:                                     return "MMddyyyy"
            case .yyyyMMdd:                                     return "yyyyMMdd"
            case .yyyyMMddHHmmss:                               return "yyyyMMddHHmmss"
            case .userBased:                                    return ""
        }
    }
    
}

extension Date {
    
    static var dateFormatter: DateFormatter {
        let tempDateFormatter = DateFormatter.init()
        tempDateFormatter.locale = Locale.current
        return tempDateFormatter
    }
    
    static var calendar: Calendar {
        let tempCalendar = Calendar.current
        return tempCalendar
    }
    
    /**
     Method to get company time zone
     - parameter isUTC: Represents boolean for UTC
     - returns TimeZone object
     */
    static func getTimeZone(isUTC: Bool = false) -> TimeZone {
        if isUTC == true {
            return TimeZone.init(identifier: "UTC") ?? TimeZone.autoupdatingCurrent
        }
//        if let timeZone = TimeZone(identifier: CompanyModel.current?.timezone?.name ?? "") {
//            return timeZone
//        }
//        if let timeZone = TimeZone.init(secondsFromGMT: CompanyModel.current?.timezone?.gmt_offset ?? 0) {
//            return timeZone
//        }
        return TimeZone.autoupdatingCurrent
    }
    
    /**
     Method to get date format
     - parameter dateFormat: Represents Date format
     - returns String
     */
    static func getDateFormatValue(_ dateFormat: DateFormat) -> String {
        switch dateFormat {
            case .userBased(let value):     return value
            default:                        return dateFormat.value
        }
    }
    
    /**
     Method to convert local time to GMT
     - returns Date
     */
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    /**
     Method to convert date to local
     - returns Date
     */
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    /**
     Method to convert current datetime to only date
     - returns Date
     */
    static func onlyDate() -> Date {
        let stringDate = Date.stringDate(fromDate: Date.init(), dateFormat: DateFormat.yyyyMMdd)
        return Date.date(fromString: stringDate, dateFormat: DateFormat.yyyyMMdd) ?? Date.init()
    }
    
    /**
     Method to convert date from string
     - parameter stringDate: Represent date in string format
     - parameter dateFormat: Represent date formate
     - parameter isUTC: Represent boolean to indicate UTC time
     - returns Date
     */
    static func date(fromString stringDate: String?, dateFormat: DateFormat, isUTC: Bool = false) -> Date? {
        if ((stringDate?.count ?? 0) <= 0) {
            return nil
        }
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = Date.getDateFormatValue(dateFormat)
//        if isUTC == true {
//            dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
//        }
        dateFormatter.timeZone = Date.getTimeZone(isUTC: isUTC)
        let date = dateFormatter.date(from: stringDate!)
        return date
    }
    
    /**
     Method to convert date string from date
     - parameter date: Represent date object
     - parameter dateFormat: Represent date formate
     - parameter isUTC: Represent boolean to indicate UTC time
     - returns String
     */
    static func stringDate(fromDate date: Date?, dateFormat: DateFormat, isUTC: Bool = false) -> String? {
        if date == nil {
            return nil
        }
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = Date.getDateFormatValue(dateFormat)
//        if isUTC == true {
//            dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
//        }
        dateFormatter.timeZone = Date.getTimeZone(isUTC: isUTC)
        let stringDate = dateFormatter.string(from: date!)
        return stringDate
    }
    
    /**
     Method to convert string date to specific format
     - parameter stringDate: Represent string date
     - parameter sourceDateFormat: Represent date formate
     - parameter destinationDateFormat: Represent date formate
     - parameter isUTC: Represent boolean to indicate UTC time
     - returns String
     */
    static func stringDate(fromString stringDate: String?, sourceDateFormat: DateFormat, destinationDateFormat: DateFormat, isUTC: Bool = false) -> String? {
        if isUTC == true {
            let tempDate = Date.date(fromString: stringDate, dateFormat: sourceDateFormat, isUTC: isUTC)
            let finalStringData = Date.stringDate(fromDate: tempDate, dateFormat: destinationDateFormat)
            return finalStringData
        }
        let tempDate = Date.date(fromString: stringDate, dateFormat: sourceDateFormat)
        let finalStringData = Date.stringDate(fromDate: tempDate, dateFormat: destinationDateFormat)
        return finalStringData
    }
    
    /**
     Method to convert timestamp to date
     - parameter timestamp: Represent timestamp number
     - returns Date
     */
    static func date(fromTimestamp timestamp: Double?) -> Date? {
        if timestamp == nil {
            return nil
        }
        let date = Date.init(timeIntervalSince1970: timestamp!)
        return date
    }
    
    /**
     Method to convert timestamp to string date in specified format
     - parameter timestamp: Represent timestamp number
     - parameter dateFormat: Represent date formate
     - parameter isUTC: Represent boolean to indicate UTC time
     - returns String
     */
    static func stringDate(fromTimestamp timestamp: Double?, dateFormat: DateFormat, isUTC: Bool = true) -> String? {
        if timestamp == nil || timestamp == 0 {
            return nil
        }
        let date = Date.init(timeIntervalSince1970: timestamp!)
        return Date.stringDate(fromDate: date, dateFormat: dateFormat, isUTC: isUTC)
    }
    
    /**
     Static Method to get age from date
     - parameter stringDate: Represent date string
     - parameter dateFormat: Represent date formate
     - returns Int
     */
    static func toAge(fromString stringDate: String?, dateFormat: DateFormat) -> Int {
        let age = Date.date(fromString: stringDate, dateFormat: dateFormat)?.toAge()
        return age ?? 0
    }
    
    /**
     Method to get age from date
     - parameter stringDate: Represent date string
     - parameter dateFormat: Represent date formate
     - returns Int
     */
    func toAge() -> Int {
        let dateComponents = Date.calendar.dateComponents([.year], from: self, to: Date.init())
        let age = dateComponents.year ?? 0
        return age
    }
    
    /**
     Method to get date from age
     - parameter age: Represent age
     - returns Date
     */
    static func date(fromAge age: Int) -> Date? {
        var components = Date.calendar.dateComponents([.year, .month, .day], from: Date.init())
        components.year = components.year! - age
        let ageYearDate = Date.calendar.date(from: components)!
        let date = Date.calendar.date(byAdding: .day, value: -1, to: ageYearDate)!
        return date
    }
    
    /**
     Method to get current month first date
     - returns Date
     */
    static func currentMonthFirstDate() -> Date! {
        var components = Date.calendar.dateComponents([.year, .month], from: Date.init())
        components.timeZone = Date.getTimeZone()
        let date = Date.calendar.date(from: components)!
        return date
    }
    
    /**
     Method to get current month first date with specific string dateformat
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func currentMonthFirstDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.currentMonthFirstDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get current month last date
     - returns Date
     */
    static func currentMonthLastDate() -> Date {
        var components = DateComponents.init()
        components.month = 1
        components.day = -1
        let date = Date.calendar.date(byAdding: components, to: Date.currentMonthFirstDate())!
        return date
    }
    
    /**
     Method to get current month last date with specific string dateformat
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func currentMonthLastDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.currentMonthLastDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get current year first date
      - returns Date
     */
    static func currentYearFirstDate() -> Date! {
        var components = Date.calendar.dateComponents([.year, .month], from: Date.init())
        components.timeZone = Date.getTimeZone()
        components.month = 1
        components.year = (components.year ?? 0) + 1
        components.day = 1
        let date = Date.calendar.date(from: components)!
        return date
    }
    
    /**
     Method to get current year first date with specific string dateformat
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func currentYearFirstDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.currentYearFirstDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get current year last date
     - returns Date
     */
    static func currentYearLastDate() -> Date! {
        var components = Date.calendar.dateComponents([.year], from: self.currentYearFirstDate())
        components.timeZone = Date.getTimeZone()
        components.year = components.year! + 1
        let firstDateOfNextYear = Date.calendar.date(from: components)!
        let date = Date.calendar.date(byAdding: .day, value: -1, to: firstDateOfNextYear)!
        return date
    }
    
    /**
     Method to get current year last date with specific string dateformat
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func currentYearLastDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.currentYearLastDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get last month last date
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func lastMonthLastDate() -> Date {
        var components = DateComponents.init()
        components.month = 1
        components.day = -1
        let date = Date.calendar.date(byAdding: components, to: Date.firstDateOfLastNumberOfMonths())!
        return date
    }
    
    /**
     Method to get last month last date with specific string dateformat
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func lastMonthLastDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.lastMonthLastDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get first date from x month from current month
     - parameter numberOfMonths: Represent number of months
     - returns Date
     */
    static func firstDateOfLastNumberOfMonths(_ numberOfMonths: Int = 1) -> Date! {
        let currentMonthDate = Date.currentMonthFirstDate()!
        let date = Date.calendar.date(byAdding: .month, value: (0 - numberOfMonths), to: currentMonthDate)!
        return date
    }
    
    /**
     Method to get first date from x month from current month with specific format
     - parameter numberOfMonths: Represent number of months
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func firstDateOfLastNumberOfMonths(_ numberOfMonths: Int = 1, dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.firstDateOfLastNumberOfMonths(numberOfMonths), dateFormat: dateFormat)
    }
    
    /**
     Method to get previous year first date
     - returns Date
     */
    static func previousYearFirstDate() -> Date! {
        let date = Date.calendar.date(byAdding: .year, value: -1, to: Date.currentYearFirstDate())
        return date
    }
    
    /**
     Method to get previous year first date with specific format
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func previousYearFirstDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.previousYearFirstDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get previous year last date
     - returns Date
     */
    static func previousYearLastDate() -> Date! {
        let date = Date.calendar.date(byAdding: .year, value: -1, to: Date.currentYearLastDate())!
        return date
    }
    
    /**
     Method to get previous year last date with specific format
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func previousYearLastDate(dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.previousYearLastDate(), dateFormat: dateFormat)
    }
    
    /**
     Method to get Current year
     - returns Int
     */
    static func currentYear() -> Int? {
        let components = Date.calendar.dateComponents([.year], from: Date.init())
        return components.year
    }
    
    /**
     Method to get first date of specific year
     - parameter year: Represent year
     - returns Date
     */
    static func firstDate(ofYear year: Int) -> Date? {
        var components = Date.calendar.dateComponents([.year, .month], from: Date.init())
        components.month = 1
        components.year = year + 1
        components.day = 1
        let date = Date.calendar.date(from: components)!
        return date
    }
    
    /**
     Method to get first date of year with specific format
     - parameter year: Represent year
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func firstDate(ofYear year: Int, dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.firstDate(ofYear: year), dateFormat: dateFormat)
    }
    
    /**
     Method to get last date of specific year
     - parameter year: Represent year
     - returns Date
     */
    static func lastDate(ofYear year: Int) -> Date? {
        var components = Date.calendar.dateComponents([.year], from: self.firstDate(ofYear: year)!)
        components.year = components.year! + 1
        let firstDateOfNextYear = Date.calendar.date(from: components)!
        let date = Date.calendar.date(byAdding: .day, value: -1, to: firstDateOfNextYear)!
        return date
    }
    
    /**
     Method to get last date of specific year with specific format
     - parameter year: Represent year
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func lastDate(ofYear year: Int, dateFormat: DateFormat) -> String? {
        return Date.stringDate(fromDate: Date.lastDate(ofYear: year), dateFormat: dateFormat)
    }
    
}

extension TimeInterval {
    
    /**
     Custom init method to initiate date from timestamp
     */
    init(fromTimestamp timestamp: Double) {
        var stringTimestamp = timestamp.string
        if stringTimestamp.contains(".") {
            stringTimestamp = stringTimestamp.components(separatedBy: ".").first ?? stringTimestamp
        }
        if stringTimestamp.count > 10 {
            var multipler: Double = 1
            let additional = stringTimestamp.count - 10
            for _ in 1...additional {
                multipler = multipler * 10
            }
            self = (timestamp / multipler)
            return
        }
        self = timestamp
    }
    
    /**
     Custom init new date from date
     */
    init(fromDate date: Date) {
        let stringTimeInterval = date.timeIntervalSince1970.string
        if stringTimeInterval.contains(".") {
            let timeInterval = stringTimeInterval.components(separatedBy: ".").first!
            self = timeInterval.toDouble()
        } else {
            self = stringTimeInterval.toDouble()
        }
    }
    
    /**
     Method to get timeinterval from currentdat
     - parameter isUTC: Represent boolean value for UTC
     - parameter bufferTime: Represent buffer time
     - returns timeinterval
     */
    static func current(isUTC: Bool = false, withBufferTime bufferTime: Double = 0) -> TimeInterval {
        if isUTC == true {
            let date = Date.init()
            let stringDate = Date.stringDate(fromDate: date, dateFormat: DateFormat.defaultDateTimeUS)
            if let currentUTCDate = Date.date(fromString: stringDate, dateFormat: DateFormat.defaultDateTimeUS, isUTC: isUTC) {
                var timeInterval = TimeInterval.init(fromDate: currentUTCDate)
                timeInterval = timeInterval + bufferTime
                return timeInterval
            }
        }
        var timeInterval = TimeInterval.init(fromDate: Date.init())
        timeInterval = timeInterval + bufferTime
        return timeInterval
    }
    
}

extension Date {
    
    /**
     Method to get company timezone
     - returns TimeZone
     */
    static func getCompanyTimeZone(timezone : String, gmt_offset : Int = 0) -> TimeZone? {
        return TimeZone.init(secondsFromGMT: gmt_offset) ?? TimeZone(identifier: timezone)
    }
    
    /**
     Method to get current timezone
     - parameter isUTC: Represent boolean value for UTC
     - returns TimeZone
     */
    static func getCurrentTimeZone(isUTC: Bool = false) -> TimeZone {
        if isUTC == true {
            return TimeZone.init(identifier: "UTC") ?? TimeZone.autoupdatingCurrent
        }
        return TimeZone.current
    }
    
    /**
     Method to convert current datetime to company timezone datetime
     - returns Date
     */
    func currentToCompany(timezone : String) -> Date {
        guard let timeZoneCompany = Date.getCompanyTimeZone(timezone: timezone) else {return self}
        let timeIntervalDiff = TimeInterval.init(timeZoneCompany.secondsFromGMT(for: self) - Date.getCurrentTimeZone().secondsFromGMT(for: self))
        return self.addingTimeInterval(timeIntervalDiff)
    }
    
    /**
     Method to convert UTC datetime to Company timezone datetime
     - returns Date
     */
    func utcToCompany(timezone : String) -> Date {
        guard let timeZoneCompany = Date.getCompanyTimeZone(timezone: timezone) else {return self}
        let timeIntervalDiff = TimeInterval.init(Date.getCurrentTimeZone(isUTC: true).secondsFromGMT(for: self) - timeZoneCompany.secondsFromGMT(for: self))
        return self.addingTimeInterval(timeIntervalDiff)
    }
    
    /**
     Method to convert current datetime to UTC datetime
     - returns Date
     */
    func currentToUTC() -> Date {
        let timeIntervalDiff = TimeInterval.init(Date.getCurrentTimeZone().secondsFromGMT(for: self) - Date.getCurrentTimeZone(isUTC: true).secondsFromGMT(for: self))
        return self.addingTimeInterval(timeIntervalDiff)
    }
    
    /**
     Method to convert UTC to current datetime
     - returns Date
     */
    func utcToCurrent() -> Date {
        let timeIntervalDiff = TimeInterval.init(Date.getCurrentTimeZone(isUTC: true).secondsFromGMT(for: self) - Date.getCurrentTimeZone().secondsFromGMT(for: self))
        return self.addingTimeInterval(timeIntervalDiff)
    }
    
    /**
     Method to convert company timezone datetime to UTC timezone datetime in string format
     - parameter stringDate: Represents Date in string format
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func companyToUTC(stringDate: String, dateFormat: DateFormat, timezone: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.value
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = Date.getCompanyTimeZone(timezone: timezone)
        
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = dateFormat.value
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    /**
     Method to convert UTC datetime to company timezone datetime in string format
     - parameter stringDate: Represents Date in string format
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func utcToCompany(stringDate: String, dateFormat: DateFormat, timezone: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.value
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.timeZone = Date.getCompanyTimeZone(timezone: timezone)
            dateFormatter.dateFormat = dateFormat.value
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    /**
     Method to convert current timezone datetime to UTC timezone datetime in string format
     - parameter stringDate: Represents Date in string format
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func currentToUTC(stringDate: String, dateFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.value
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = Date.getCurrentTimeZone()
        
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = dateFormat.value
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    /**
     Method to convert UTC datetime to current timezone datetime in string format
     - parameter stringDate: Represents Date in string format
     - parameter dateFormat: Represent dataformat
     - returns String
     */
    static func utcToCurrent(stringDate: String, dateFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.value
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.timeZone = Date.getCurrentTimeZone()
            dateFormatter.dateFormat = dateFormat.value
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}
