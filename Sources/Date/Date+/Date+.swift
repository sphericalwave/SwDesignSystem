//
//  Date+Extension.swift
//  FoodSearch
//
//  Created by Aaron Anthony on 2018-06-18.
//  Copyright © 2018 SphericalWave. All rights reserved.
//

import Foundation

public extension Date {
    func previousDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let previousDay = calendar.date(byAdding: .day, value: -1, to: self) else {
            fatalError("Shouldn't happen ever")
        }
        return previousDay
    }
    
    func nextDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let nextDay = calendar.date(byAdding: .day, value: 1, to: self) else {
            fatalError("Shouldn't happen ever")
        }
        return nextDay
    }
    
    func incrementDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: self) else { fatalError("Shouldn't happen ever") }
        print("Day: \(self.description)")
        print("Incremented: \(endOfDay.description)")
        return endOfDay
    }
    
    func startOfDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        let midnight = calendar.startOfDay(for: self)
        //print("StartOfDay: \(midnight.description)")
        return midnight
    }
    
    func endOfDay() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        let midnight = self.startOfDay()
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: midnight) else {
            fatalError("Shouldn't happen ever")
        }
        //print("EndOfDay: \(endOfDay.description)")
        return endOfDay
    }
    
    var hour: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        components.minute = 0
        guard let n = Calendar.current.date(from: components) else { fatalError() }
        return n
    }
    
    var noon: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        components.hour = 12
        components.minute = 0
        guard let n = Calendar.current.date(from: components) else { fatalError() }
        //print(n.description)
        return n
    }
    
//    func endOfDay() -> Date {
//        let calendar = Calendar.autoupdatingCurrent
//        let midnight = self.startOfDay()
//        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: midnight) else {
//            fatalError("Shouldn't happen ever")
//        }
//        //print("EndOfDay: \(endOfDay.description)")
//        return endOfDay
//    }
    
    var weekdayOrdinal: Int { // returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
        return Calendar.current.component(.weekday, from: self)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    func plus30days() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let endOfDay = calendar.date(byAdding: .day, value: 30, to: self) else {
            fatalError("Shouldn't happen ever")
        }
        print("Day: \(self.description)")
        print("plus30days: \(endOfDay.description)")
        return endOfDay
    }
    
    func minus30days() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let endOfDay = calendar.date(byAdding: .day, value: -30, to: self) else {
            fatalError("Shouldn't happen ever")
        }
        return endOfDay
    }
    
    func minus7days() -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let endOfDay = calendar.date(byAdding: .day, value: -7, to: self) else {
            fatalError("Shouldn't happen ever")
        }
        return endOfDay
    }
    
    
    func minus(days: Int) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        guard let endOfDay = calendar.date(byAdding: .day, value: days, to: self) else {
            fatalError("Shouldn't happen ever")
        }
        return endOfDay
    }
    
    func calculateAge() -> (year :Int, month : Int, day : Int) {
        //print("calculateAge")
        var years = 0
        var months = 0
        var days = 0
        
        let cal = Calendar.current
        years = cal.component(.year, from: Date()) -  cal.component(.year, from: self)
        
        let currMonth = cal.component(.month, from: Date())
        let birthMonth = cal.component(.month, from: self)
        
        //get difference between current month and birthMonth
        months = currMonth - birthMonth
        //if month difference is in negative then reduce years by one and calculate the number of months.
        if months < 0 {
            years = years - 1
            months = 12 - birthMonth + currMonth
            if cal.component(.day, from: Date()) < cal.component(.day, from: self) {
                months = months - 1
            }
        }
        else if months == 0 && cal.component(.day, from: Date()) < cal.component(.day, from: self) {
            years = years - 1
            months = 11
        }
        
        //Calculate the days
        if cal.component(.day, from: Date()) > cal.component(.day, from: self) {
            days = cal.component(.day, from: Date()) - cal.component(.day, from: self)
        }
        else if cal.component(.day, from: Date()) < cal.component(.day, from: self) {
            let today = cal.component(.day, from: Date())
            let date = cal.date(byAdding: .month, value: -1, to: Date())
            
            days = date!.daysInMonth - cal.component(.day, from: self) + today
        }
        else {
            days = 0
            if months == 12 {
                years = years + 1
                months = 0
            }
        }
        
        return (years, months, days)
    }
    
    var daysInMonth: Int {
        let calendar = Calendar.current
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
    func last12Mths() -> [Date] {
        let calendar = Calendar.current
        let currentDate = self

        var dates: [Date] = []

        for month in 0..<12 {
            if let date = calendar.date(byAdding: .month, value: -month, to: currentDate) {
                let d = date.firstNoonOfMonth()
                dates.append(d)
            }
        }
        return dates
    }
    
    func firstNoonOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        components.hour = 12
        components.minute = 0
        guard let n = Calendar.current.date(from: components) else { fatalError() }
        //print(n.description)
        return n
    }
}

public extension Date {

    func hoursInDay() -> [Date] {
       // func hoursIn(day: Date) -> [Date] {

        var hours = [Date]()
        let startOfDay = self.startOfDay()
        hours.append(startOfDay)
        let calendar = Calendar.autoupdatingCurrent
        for hour in 1..<24 {
            if let hr = calendar.date(byAdding: .hour, value: hour, to: startOfDay) {
                hours.append(hr)
            }
        }
        guard hours.count == 24 else {
            fatalError("\(hours.count)")
        }
        return hours
    }
    
    func lastWeek() -> [Date] {
        var lastWeek = [Date]()
        let noon = self.noon
        lastWeek.append(noon)
        let calendar = Calendar.autoupdatingCurrent
        for day in 1..<7 {
            if let hr = calendar.date(byAdding: .day, value: day * -1, to: noon) {
                lastWeek.append(hr)
            }
        }
        guard lastWeek.count == 7 else {
            fatalError("\(lastWeek.count)")
        }
        return lastWeek
    }
    
    func last30Days() -> [Date] {
        var last30days = [Date]()
        let noon = self.noon
        last30days.append(noon)
        let calendar = Calendar.autoupdatingCurrent
        for day in 1..<30 {
            if let hr = calendar.date(byAdding: .day, value: day * -1, to: noon) {
                last30days.append(hr)
            }
        }
        guard last30days.count == 30 else {
            fatalError("\(last30days.count)")
        }
        return last30days
    }
    
    func dates(range: Int) -> [Date] {
        
        let calendar = Calendar.current
        let currentDate = self.noon

        var dates: [Date] = []
        for day in 0..<range {
            if let date = calendar.date(byAdding: .day, value: -day, to: currentDate) {
                dates.append(date)
            }
        }
        return dates
    }
}

public extension Date {
    static var november16_1982: Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 1982
        components.month = 11
        components.day = 16
        return calendar.date(from: components)!
    }
    
    static var the_matrix: Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 1999
        components.month = 3
        components.day = 31
        return calendar.date(from: components)!
    }
    
    static var lastMondayAt3AM: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        
        // Calculate the difference in days between today and the most recent Monday
        let weekday = calendar.component(.weekday, from: Date())
        let daysToSubtract = (7 + weekday - 2) % 7  // 2 represents Monday's index
        
        // Set the components to the last Monday
        components.day! -= daysToSubtract
        components.hour = 3
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)!
    }
}


public extension Date {
    
    static func sevenToSeven() -> [Date] {

        // Get the current date and calendar
        let currentDate = Date()
        let calendar = Calendar.current

        // Define the start and end hours (in this case, 7 AM and 7 PM)
        let startHour = 7
        let endHour = 19

        // Create a date formatter to display the dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        // Create an array to store the hourly dates
        var hourlyDates: [Date] = []

        // Loop through the hours from startHour to endHour
        for hour in startHour..<endHour {
            // Create a DateComponents object with the current year, month, day, and the current hour
            var dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
            dateComponents.hour = hour
            
            // Create a Date object from the DateComponents
            if let hourDate = calendar.date(from: dateComponents) {
                hourlyDates.append(hourDate)
            }
        }

        // Print the hourly dates
//        for date in hourlyDates {
//            print(dateFormatter.string(from: date))
//        }
        return hourlyDates
    }
    
    static func generateHourlyDates() -> [Date] {
        let calendar = Calendar.current
        let now = Date().startOfDay()
        
        var hourlyDates: [Date] = []
        
        for hour in 6..<20 {
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            let date = calendar.date(byAdding: dateComponents, to: now)!
            hourlyDates.append(date)
        }
        
        return hourlyDates
    }
}

//graph labels
//TODO: tidy these up, make me more readable
@available(iOS 15.0, *)
public extension Date {
    
    func dayLabel() -> String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
    
    func timeLabel() -> String {
        self.formatted(date: .omitted, time: .shortened)
    }
    
    func weekLabel() -> String {
        "\(self.minus7days().formatted(.dateTime.month().day()))" + " - " + self.formatted(date: .abbreviated, time: .omitted)
    }
    
    func monthLabel() -> String {
        "\(self.minus30days().formatted(.dateTime.month().day()))" + " - " + self.formatted(date: .abbreviated, time: .omitted)
    }
    
    func yearLabel() -> String {
        "\(self.minus(days: -365).formatted(.dateTime.month().day().year()))" + " - " + self.formatted(date: .abbreviated, time: .omitted)
    }
}


public extension Date {
    func convertToCurrentTime() -> Date {
        // Get the current date and time
        let currentDateTime = Date()

        // Extract components from the original date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)

        // Create a new date with the components of the original date and the current time
        var newComponents = DateComponents()
        newComponents.year = components.year
        newComponents.month = components.month
        newComponents.day = components.day
        newComponents.hour = calendar.component(.hour, from: currentDateTime)
        newComponents.minute = calendar.component(.minute, from: currentDateTime)
        newComponents.second = calendar.component(.second, from: currentDateTime)

        return calendar.date(from: newComponents)!
    }
    
    static func date(year: Int, month: Int, day: Int = 1, hour: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minutes, second: seconds)) ?? Date()
    }
}

// Example usage:
//let originalDate = Date(timeIntervalSince1970: 1621074600)  // Replace with your original date
//let newDate = originalDate.convertToCurrentTime()
//print(newDate)
