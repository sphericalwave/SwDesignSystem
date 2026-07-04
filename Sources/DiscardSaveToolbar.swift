//
//  DiscardSaveToolbar.swift
//  FitWrench
//
//  Created by Aaron McGrath on 2026-03-09.
//  Copyright © 2026 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

private struct DiscardSaveToolbarModifier: ViewModifier {

    @Environment(\.dismiss) private var dismiss

    let hasChanges: Bool
    let isSaveDisabled: Bool
    let discardAction: (() -> Void)?
    let saveAction: (() -> Void)?
    let discardAccessibilityLabel: String?
    let saveAccessibilityLabel: String?

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(hasChanges)
            .toolbar {
                if hasChanges {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Discard") {
                            discardAction?()
                        }
                        .accessibilityLabel(discardAccessibilityLabel ?? "Discard")
                        .tint(.secondary)
                        .buttonStyle(.bordered)
                        .frame(maxWidth: 140)

                        Spacer()

                        Button("Save") {
                            saveAction?()
                            dismiss()
                        }
                        .accessibilityLabel(saveAccessibilityLabel ?? "Save")
                        .tint(.blue1)
                        .buttonStyle(.borderedProminent)
                        .disabled(isSaveDisabled)
                        .frame(maxWidth: 140)
                    }
                }
            }
    }
}
public extension View {
    func discardSaveToolbar(
        hasChanges: Bool,
        isSaveDisabled: Bool = false,
        discardAction: (() -> Void)? = nil,
        discardAccessibilityLabel: String? = nil,
        saveAccessibilityLabel: String? = nil,
        saveAction: (() -> Void)?
    ) -> some View {
        modifier(
            DiscardSaveToolbarModifier(
                hasChanges: hasChanges,
                isSaveDisabled: isSaveDisabled,
                discardAction: discardAction,
                saveAction: saveAction,
                discardAccessibilityLabel: discardAccessibilityLabel,
                saveAccessibilityLabel: saveAccessibilityLabel
            )
        )
    }
}
