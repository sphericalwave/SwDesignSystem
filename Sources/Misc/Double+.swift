//
//  Double+.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2024-07-15.
//  Copyright © 2024 SphericalWaveSoftware. All rights reserved.
//

import Foundation

//MARK: Double+ L14 move double extension into SwShared
public extension Double {
    func rounded(toPlaces places: Int) -> Self {
        let divisor = Self(pow(10.0, Double(places)))
        return (self * divisor).rounded() / divisor
    }
    
    /// Returns a string representation of the double as a whole number (no fractional digits),
    /// followed by "g" (e.g., 123.45 → "123g", 500.0 → "500g").
    var formattedAsGrams: String {
        self.formatted(
            .number
            .precision(.fractionLength(0)))
        + "g"
    }
    
    var formattedAsMiliLiters: String {
        self.formatted(
            .number
            .precision(.fractionLength(0)))
        + "mL"
    }
    
    var formattedAsCals: String {
        self.formatted(
            .number
            .precision(.fractionLength(0)))
        + "cal"
    }
    
    var currencyFormat: String {
        self.formatted(
            .currency(code: "CAD")
            .precision(.fractionLength(0...2))
        )
    }
    
    var pricePerLiterFormat: String {
        self.formatted(
            .currency(code: "CAD")
            .precision(.fractionLength(0...2))
        )
        + " / L"
    }
    
    var formattedAsPh: String {
        "pH " +
        self.formatted(
            .number
            .precision(.fractionLength(0...2))
        )
    }
    
    var formattedAsORP: String {
        "ORP " +
        self.formatted(
            .number
            .precision(.fractionLength(0...2))
        )
        + "mV"
    }
    
    var percentFormat: String {
        formatted(.number.precision(.fractionLength(0...1))) + "%"
    }
    
    var poundsFormat: String {
        formatted(.number.precision(.fractionLength(0...1))) + "ibs"
    }
    
    var inchesFormat: String {
        formatted(.number.precision(.fractionLength(0...1))) + "\""
    }
    
    var singleDecimalFormat: String {
        formatted(.number.precision(.fractionLength(0...1)))
    }
}
