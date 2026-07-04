//
//  Color+.swift
//  SwShared
//
//  Created by Aaron Anthony on 2021-08-04.
//  Copyright © 2021 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension Color {
    
    static let blue1 = Color(red: 25 / 255, green: 58 / 255, blue: 231 / 255) //193be8
    static let blue2 = Color(red: 25 / 255, green: 163 / 255, blue: 232 / 255) //19a3e8
    static let purple1 = Color(red: 94 / 255, green: 25 / 255, blue: 232 / 255) //purple 5e19e8
    static let orange1 = Color(red: 232 / 255, green: 94 / 255, blue: 25 / 255) //e85e19

    //sky blue 19a3e8
    static let red1 = Color(red: 232 / 255, green: 25 / 255, blue: 59 / 255) //red e8193b
    //a green 3be819
    //light purple c519e8
    static let yellow1 = Color(red: 232 / 255, green: 197 / 255, blue: 25 / 255) //e8c519
    
    static let gray1 = Color(red: 27 / 255, green: 27 / 255, blue: 27 / 255) //background gray
    static let gray2 = Color(red: 118 / 255, green: 118 / 255, blue: 118 / 255)
    static let gray3 = Color(red: 198 / 255, green: 198 / 255, blue: 198 / 255)
    static let gray4 = Color(red: 227 / 255, green: 227 / 255, blue: 227 / 255) //background gray
    static let gray5 = Color(red: 248 / 255, green: 248 / 255, blue: 248 / 255) //background gray
    static let gray6 = Color(red: 253 / 255, green: 253 / 255, blue: 253 / 255)
    static let grayAlert = Color(red: 237 / 255, green: 237 / 255, blue: 237 / 255)
}

public extension UIColor {
    static let blue1 = UIColor(red: 25 / 255, green: 58 / 255, blue: 231 / 255, alpha: 1)
}
