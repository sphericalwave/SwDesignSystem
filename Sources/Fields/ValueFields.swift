//
//  ValueFields.swift
//  SwDesignSystem
//
//  Pure-SwiftUI replacements for the retired UIKit `TerminalTF` family.
//  Same names and init signatures as the old wrappers, so call sites and
//  the Rows components migrate without churn.
//

import SwiftUI

/// Decimal input (≥ 0 semantics come from the decimal pad).
public struct DoubleTF: View {
    @Binding var double: Double?
    let placeholder: String

    public init(double: Binding<Double?>, placeholder: String) {
        self._double = double
        self.placeholder = placeholder
    }

    public var body: some View {
        TextField(placeholder, value: $double, format: .number)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}

/// Decimal input that also accepts negative values (signed keypad on iOS
/// still needs the minus typed via the numbers-and-punctuation layout).
public struct DoubleNegTF: View {
    @Binding var double: Double?
    let placeholder: String

    public init(double: Binding<Double?>, placeholder: String) {
        self._double = double
        self.placeholder = placeholder
    }

    public var body: some View {
        TextField(placeholder, value: $double, format: .number)
            #if os(iOS)
            .keyboardType(.numbersAndPunctuation)
            #endif
    }
}

/// Non-optional decimal input (the old `DoubleTFv2`).
public struct DoubleTFv2: View {
    @Binding var double: Double
    let placeholder: String

    public init(double: Binding<Double>, placeholder: String = "") {
        self._double = double
        self.placeholder = placeholder
    }

    public var body: some View {
        TextField(placeholder, value: $double, format: .number)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}

/// Whole-number input.
public struct IntegerTF: View {
    @Binding var int: Int?

    public init(int: Binding<Int?>) {
        self._int = int
    }

    public var body: some View {
        TextField("", value: $int, format: .number)
            #if os(iOS)
            .keyboardType(.numberPad)
            #endif
    }
}

/// Currency amount in the user's locale.
public struct CurrencyTF: View {
    @Binding var value: Double?

    public init(value: Binding<Double?>) {
        self._value = value
    }

    public var body: some View {
        TextField("", value: $value,
                  format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}

/// Length entry; the binding always stores INCHES, `isInches` only flips
/// the placeholder/unit hint (same contract as the old UIKit field).
public struct LengthTF: View {
    @Binding var inches: Double?
    @Binding var isInches: Bool

    public init(inches: Binding<Double?>, isInches: Binding<Bool>) {
        self._inches = inches
        self._isInches = isInches
    }

    public var body: some View {
        TextField(isInches ? "in" : "cm", value: $inches, format: .number)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}

/// Mass entry; the binding always stores POUNDS, `isPounds` only flips
/// the placeholder/unit hint (same contract as the old UIKit field).
public struct MassTF: View {
    @Binding var pounds: Double?
    @Binding var isPounds: Bool

    public init(pounds: Binding<Double?>, isPounds: Binding<Bool>) {
        self._pounds = pounds
        self._isPounds = isPounds
    }

    public var body: some View {
        TextField(isPounds ? "lbs" : "kg", value: $pounds, format: .number)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
    }
}
