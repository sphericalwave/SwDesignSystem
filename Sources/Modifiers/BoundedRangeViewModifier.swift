//
//  BoundedRangeViewModifier.swift
//  Calibrations
//
//  Created by Aaron Anthony on 2024-10-18.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
public struct BoundedRangeViewModifier: ViewModifier {
    
    @Binding var text: String
    var lowerBound: Double
    var upperBound: Double
    
    public func body(content: Content) -> some View {
        content
            .onReceive(Just(text)) { newValue in
                if let value = Double(newValue) {
                    // Clamp value between lowerBound and upperBound
                    if value < lowerBound {
                        self.text = String(format: "%.0f", lowerBound)
                    } else if value > upperBound {
                        self.text = String(format: "%.0f", upperBound)
                    }
                } else if newValue.isEmpty {
                    // Ensure empty text is valid
                    self.text = ""
                }
            }
    }
}

@available(iOS 13.0, *)
extension View {
    public func boundedRange(_ text: Binding<String>, lowerBound: Double = 1, upperBound: Double = 1000) -> some View {
        self.modifier(BoundedRangeViewModifier(text: text, lowerBound: lowerBound, upperBound: upperBound))
    }
}
