//
//  TagTextModifier.swift
//  FitWrench
//
//  Created by Aaron McGrath on 2025-08-04.
//  Copyright © 2025 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct TagTextModifier: ViewModifier {
    public init() { }

    public func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .foregroundColor(.primary)
    }
}

public extension View {
     func tagText() -> some View {
        modifier(TagTextModifier())
    }
}

#Preview {
    Text("Testing").tagText()
}
