//
//  ReadableDate.swift
//  ContractorPortal
//
//  Created by Aaron Anthony on 2021-06-08.
//

import Foundation

extension Date {
    func fmtTime() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "h:mm a"
        frmt2.amSymbol = "AM"
        frmt2.pmSymbol = "PM"
        return frmt2.string(from: self)
    }
    
    func fmtMthDayYrTime() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        frmt2.amSymbol = "AM"
        frmt2.pmSymbol = "PM"
        return frmt2.string(from: self)
    }
    
    func fmtMthDay() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MM/dd"
        return frmt2.string(from: self)
    }
    
    func fmtMthDayYear() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MM/dd/YYYY"
        return frmt2.string(from: self)
    }
    
    func fmtMthDayPretty() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMM d"
        return frmt2.string(from: self)
    }
    
    func fmtMthDayPretty2() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM d"
        return frmt2.string(from: self)
    }
    
    /// e,g. September 9, 2022
    func fmtMthDayYr() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM d, yyyy"
        return frmt2.string(from: self)
    }
    
    func fmtMthDayYrNumeric() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "M/d/yy"
        return frmt2.string(from: self)
    }
    
    func fmtMthYr() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "MMMM yyyy"
        return frmt2.string(from: self)
    }
    
    /// e.g. Friday
    func fmtDay() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "EEEE"
        return frmt2.string(from: self)
    }
    
    func fmtCalDay() -> String {
        let frmt2 = DateFormatter()
        frmt2.dateFormat = "dd"
        return frmt2.string(from: self)
    }
}
