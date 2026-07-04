//
//  SwiftUIView.swift
//  
//
//  Created by Aaron Anthony on 2023-10-18.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SwGradient: View {
    
    @Environment(\.colorScheme) var colorScheme

    public init() { }
    
    public var body: some View {
        LinearGradient(
            colors: [.blue1, colorScheme == .light ? .white: .black],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

@available(iOS 14.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwGradient()
    }
}
