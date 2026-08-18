//
//  SwDateNav.swift
//  SwDesignSystem
//
//  Created by Aaron Anthony on 2026-08-18.
//  Copyright © 2026 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

/// Compact day stepper: previous chevron, date picker, next chevron.
/// Hugs its content so it stays centered in a toolbar principal slot.
public struct SwDateNav: View {
    @Binding var day: Date
    let previousAccessibilityLabel: String
    let nextAccessibilityLabel: String

    public init(
        day: Binding<Date>,
        previousAccessibilityLabel: String = "Previous Day",
        nextAccessibilityLabel: String = "Next Day"
    ) {
        self._day = day
        self.previousAccessibilityLabel = previousAccessibilityLabel
        self.nextAccessibilityLabel = nextAccessibilityLabel
    }

    public var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.leading, 8)
                .padding(.trailing, 2)
                .contentShape(Rectangle())
                .onTapGesture { shiftDay(by: -1) }
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel(previousAccessibilityLabel)

            SwDatePicker(day: $day, components: [.date])
                .fixedSize()
                .padding(.horizontal, -6)

            Image(systemName: "chevron.right")
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.leading, 2)
                .padding(.trailing, 8)
                .contentShape(Rectangle())
                .onTapGesture { shiftDay(by: 1) }
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel(nextAccessibilityLabel)
        }
        .fixedSize()
    }

    private func shiftDay(by days: Int) {
        day = Calendar.current.date(byAdding: .day, value: days, to: day) ?? day
    }
}
