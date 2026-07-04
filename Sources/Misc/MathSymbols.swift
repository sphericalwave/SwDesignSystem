//
//  MathSymbols.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2024-09-28.
//  Copyright © 2024 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct MultiplySymbol: View {
    public init() { }

    public var body: some View {
        Image(systemName: "multiply")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundColor(.blue1)
    }
}

public struct EqualSymbol: View {
    public init() { }

    public var body: some View {
        Image(systemName: "equal")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 15, height: 15)
            .foregroundColor(.blue1)
    }
}

#Preview {
    HStack {
        MultiplySymbol()
        EqualSymbol()
    }
}
