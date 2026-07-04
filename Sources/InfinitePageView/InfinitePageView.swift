//
//  InfinitePageView.swift
//  GroundhogDay
//
//  Created by Aaron Anthony on 2024-10-22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct InfinitePageView<C, T>: View where C: View, T: Hashable {
    @Binding public var selection: T

    let before: (T) -> T
    let after: (T) -> T

    @ViewBuilder let view: (T) -> C

    @State private var currentTab: Int = 0
    
    public init(selection: Binding<T>,
                before: @escaping (T) -> T,
                after: @escaping (T) -> T,
                view: @escaping (T) -> C) {
        self._selection = selection
        self.before = before
        self.after = after
        self.view = view
    }

    public var body: some View {
        let previousIndex = before(selection)
        let nextIndex = after(selection)
        TabView(selection: $currentTab) {
            view(previousIndex)
                .tag(-1)

            view(selection)
                .onDisappear() {
                    if currentTab != 0 {
                        selection = currentTab < 0 ? previousIndex : nextIndex
                        currentTab = 0
                    }
                }
                .tag(0)

            view(nextIndex)
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .disabled(currentTab != 0) // FIXME: workaround to avoid glitch when swiping twice very quickly
    }
}
