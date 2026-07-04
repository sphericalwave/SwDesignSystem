//
//  Calendar+.swift
//  ContractorPortal
//
//  Created by Aaron Anthony on 2021-06-28.
//

import Foundation

extension Calendar
{
    
//    let cal = Calendar.current
//    guard let weekInterval = cal.dateInterval(of: .weekOfYear, for: starts) else { fatalError() }
//    let dC = DateComponents(hour: 0, minute: 0, second: 0)
//    let dates = cal.dates(interval: weekInterval, components: dC)
    
    //TODO: in progress used in SwMacros calc
    func dates(start: Date, end: Date, components: Calendar.Component) -> [Date] {
        let i = DateInterval(start: start, end: end)
        let dC = DateComponents(hour: 0, minute: 0, second: 0)
        return self.dates(interval: i, components: dC)
    }
    
    func dates(interval: DateInterval, components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end { dates.append(date) }
                else { stop = true }
            }
        }
        return dates
    }
    
    func daysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
