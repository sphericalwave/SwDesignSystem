//
//  AddDropToolbar.swift
//  FitWrench
//
//  Created by Aaron McGrath on 2026-03-16.
//

import SwiftUI

private struct AddDropToolbarModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    let addAction: () -> Void
    let dropAction: (() -> Void)?
    let isAddDisabled: Bool
    let dropAccessibilityLabel: String?
    let addAccessibilityLabel: String?

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        dropAction?()
                        dismiss()
                    }) {
                        Image(systemName: "arrow.down.square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.secondary)
                            .frame(width: 33, height: 33)
                    }
                    .accessibilityLabel(dropAccessibilityLabel ?? "Drop")

                    Spacer()

                    PlusBtn2(didTap: addAction)
                        .accessibilityLabel(addAccessibilityLabel ?? "Add")
                        .disabled(isAddDisabled)
                }
            }
    }
}

public extension View {
    func addDropToolbar(
        dropAction: (() -> Void)? = nil,
        isAddDisabled: Bool = false,
        dropAccessibilityLabel: String? = nil,
        addAccessibilityLabel: String? = nil,
        addAction: @escaping () -> Void
    ) -> some View {
        modifier(
            AddDropToolbarModifier(
                addAction: addAction,
                dropAction: dropAction,
                isAddDisabled: isAddDisabled,
                dropAccessibilityLabel: dropAccessibilityLabel,
                addAccessibilityLabel: addAccessibilityLabel
            )
        )
    }
}
