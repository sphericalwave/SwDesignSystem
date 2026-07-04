//
//  ColorScheme+.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-10-21.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension ColorScheme {
    var buttonColor: Color {
        if self == .dark {
            return .white
        } else {
            return .blue1
        }
    }
}


//MARK: usage

//@Environment(\.colorScheme) private var colorScheme

//colorScheme.buttonColor
