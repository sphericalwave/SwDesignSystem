//
//  SwiftUIView.swift
//  
//
//  Created by Aaron Anthony on 2023-10-21.
//

import SwiftUI

@available(iOS 15.0, *)
public struct DeleteBtn: View {
    
    @Environment(\.colorScheme) private var colorScheme
    var didTap: (() -> Void)?
    
    public init(didTap: (() -> Void)? = nil) {
        self.didTap = didTap
    }
    
    public var body: some View {
        Button(action: { didTap?() } ) {
            Text("Delete")
            //.foregroundColor(colorScheme == .dark ? .primary : .red)
                .foregroundColor(.red)
        }
        .buttonStyle(.bordered)
    }
}
