//
//  TagModifier.swift
//  BioMechanic
//
//  Created by Aaron Anthony on 2024-10-28.
//

import SwiftUI

// Define the custom ViewModifier with a color parameter
@available(iOS 15.0, *)
public struct TagModifier: ViewModifier {
    var color: Color
    
    public init(color: Color) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(.white)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(color))
    }
}

// Extend View to add tagModifier as a custom modifier with a color parameter
@available(iOS 15.0, *)
extension View {
    public func tagModifier(color: Color) -> some View {
        self.modifier(TagModifier(color: color))
    }
}
