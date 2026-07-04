//
//  ReadableDate.swift
//  ContractorPortal
//
//  Created by Aaron Anthony on 2021-06-08.
//

import Foundation

public struct ReadableDate
{
    let d: Date

    public init(date: Date) {
        self.d = date
    }
    
    public func mthDayYrTime() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM d, yyyy HH:mm a"
        frmt2.amSymbol = "AM"
        frmt2.pmSymbol = "PM"
        return frmt2.string(from: d)
    }
    
    public func timeWithoutAMPM() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "HH:mm"
        return frmt2.string(from: d)
    }
    
    public func timeWithAMPM() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "HH:mm a"
        frmt2.amSymbol = "AM"
        frmt2.pmSymbol = "PM"
        return frmt2.string(from: d)
    }
    
    public func timeWithAMPM2() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "ha"
        frmt2.amSymbol = "AM"
        frmt2.pmSymbol = "PM"
        return frmt2.string(from: d)
    }
    
    public func mthDay() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MM/dd"
        return frmt2.string(from: d)
    }
    
    public func mthDayYr() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM d, yyyy"
        return frmt2.string(from: d)
    }
    
    public func mthYr() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM yyyy"
        return frmt2.string(from: d)
    }
}
