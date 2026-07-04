//
//  HdrText.swift
//  SwDesignSystem
//
//  Large centered header text on the chart/header background. (Recovered
//  from SwShared's misnamed `SwiftUIView.swift`.)
//

import SwiftUI

public struct HdrText: View {

    let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(.title)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .chartBackgroundMod()
            .headerBackgroundMod()
    }
}
