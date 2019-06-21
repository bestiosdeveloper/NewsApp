//
//  DateExtention.swift
//
//  Created by Pramod Kumar on 19/09/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//


import Foundation

extension Date {
    
    var isToday:Bool{
        return Calendar.current.isDateInToday(self)
    }
    var isYesterday:Bool{
        return Calendar.current.isDateInYesterday(self)
    }
    var isTomorrow:Bool{
        return Calendar.current.isDateInTomorrow(self)
    }
    var isWeekend:Bool{
        return Calendar.current.isDateInWeekend(self)
    }
    var year:Int{
        return (Calendar.current as NSCalendar).components(.year, from: self).year!
    }
    var month:Int{
        return (Calendar.current as NSCalendar).components(.month, from: self).month!
    }
    var weekOfYear:Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: self).weekOfYear!
    }
    var weekday:Int{
        return (Calendar.current as NSCalendar).components(.weekday, from: self).weekday!
    }
    var weekdayOrdinal:Int{
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: self).weekdayOrdinal!
    }
    var weekOfMonth:Int{
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: self).weekOfMonth!
    }
    var day:Int{
        return (Calendar.current as NSCalendar).components(.day, from: self).day!
    }
    var hour:Int{
        return (Calendar.current as NSCalendar).components(.hour, from: self).hour!
    }
    var minute:Int{
        return (Calendar.current as NSCalendar).components(.minute, from: self).minute!
    }
    var second:Int{
        return (Calendar.current as NSCalendar).components(.second, from: self).second!
    }
    var numberOfWeeks:Int{
        let weekRange = (Calendar.current as NSCalendar).range(of: .weekOfYear, in: .month, for: Date())
        return weekRange.length
    }
    var unixTimestamp:Double {
        
        return self.timeIntervalSince1970
    }
    
    var age:Int{
       
        let calendar : Calendar = Calendar.current
        let unitFlags : NSCalendar.Unit = [NSCalendar.Unit.year , NSCalendar.Unit.month , NSCalendar.Unit.day]
        let dateComponentNow : DateComponents = (calendar as NSCalendar).components(unitFlags, from: Date())
        let dateComponentBirth : DateComponents = (calendar as NSCalendar).components(unitFlags, from: self)
        
        if ( (dateComponentNow.month! < dateComponentBirth.month!) ||
            ((dateComponentNow.month! == dateComponentBirth.month!) && (dateComponentNow.day! < dateComponentBirth.day!))
            )
        {
            return dateComponentNow.year! - dateComponentBirth.year! - 1
        }
        else {
            return dateComponentNow.year! - dateComponentBirth.year!
        }
    }
    
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    func weekdayFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekday, from: date, to: self, options: []).weekday!
    }
    func weekdayOrdinalFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekdayOrdinal, from: date, to: self, options: []).weekdayOrdinal!
    }
    func weekOfMonthFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfMonth, from: date, to: self, options: []).weekOfMonth!
    }
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    func offsetFrom(_ date:Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    ///Converts a given Date into String based on the date format and timezone provided
    func toString(dateFormat:String,timeZone:TimeZone = TimeZone.current)->String {
        
        let frmtr = DateFormatter()
        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = timeZone
        return frmtr.string(from: self)
    }
    
    fileprivate func dateComponents() -> DateComponents {
        let calander = Calendar.current
        return (calander as NSCalendar).components([.second, .minute, .hour, .day, .month, .year], from: self, to: Date(), options: [])
    }
    
    public var timeAgo: String {
        
        let components = self.dateComponents()
        
        if components.year! > 0 {
            return  "\(components.year ?? 0)Y ago"
        }
        
        if components.month! > 0 {
            return "\(components.month ?? 0)M ago"
        }
        
        if components.day! >= 7 {
            let week = components.day!/7
            return "\(week)W ago"
        }
        
        if components.day! > 0 {
            return "\(components.day ?? 0)d ago"
        }
        
        if components.hour! > 0 {
            return "\(components.hour ?? 0)h ago"
        }
        
        if components.minute! > 0 {
            return "\(components.minute ?? 0)m ago"
        }
        if components.second! > 10 {
            return "\(components.second ?? 0)s ago"
        }
        if components.second! < 10 {
            return "Just now"
        }
        return ""
    }
    
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func timeAgo(numericDates:Bool) -> String {
        
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        
        let earliest = NSDate().earlierDate(self)
        let now = Date()
        let latest = (earliest == now) ? self : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        }
        else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    func addDay(days: Int = 0) -> String? {
        let components = DateComponents(year: 0, month: 0, day: days, hour: 0, minute: 0, second: 0)
        return Calendar.current.date(byAdding: components, to: self)?.toString(dateFormat: "yyyy-MM-dd")
    }
    
    
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }
    
    ///GetDateFromString
    static func getDateFromString(stringDate: String, currentFormat: String, requiredFormat: String) -> String? {
        //String to Date Convert
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        guard let date = dateFormatter.date(from: stringDate) else {return nil}
        //CONVERT FROM Date to String
        dateFormatter.dateFormat = requiredFormat
        return dateFormatter.string(from: date)
    }
}

