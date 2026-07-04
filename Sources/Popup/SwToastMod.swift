//
//  SwToastMod.swift
//  fu3l
//
//  Created by Aaron Anthony on 2022-11-23.
//  Copyright © 2022 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct SwToastMod: ViewModifier {
    public init() { }

    public func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity, idealHeight: 100, alignment: .leading)
            .background(Color.blue1.opacity(0.8))
            .cornerRadius(4)
            .shadow(radius: 9)
            .padding()
    }
}
