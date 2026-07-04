//
//  Crop.swift
//  PhotoCrop
//
//  Created by Aaron Anthony on 2023-05-26.
//

import SwiftUI

public enum CropMethod: Equatable {
    
    case original
    case freeform
    case square
    case ratio16_9
    case ratio4_5
    case ratio5_7
    case ratio4_3
    case ratio3_5
    case ratio3_2
    case circle
    case rectangle
    case custom(CGSize)
    
    public static func allCases() -> [CropMethod] {
        return [
            .original,
            .freeform,
            .square,
            .circle,
            .ratio16_9,
            .ratio4_5,
            .ratio5_7,
            .ratio4_3,
            .ratio3_5,
            .ratio3_2
        ]
    }
    
    public func name() -> String {
        var s = ""
        switch self {
        case .original: s = "Original"
        case .freeform: s = "Freeform"
        case .square: s = "Square"
        case .ratio16_9: s = "16:9"
        case .ratio4_5: s = "4:5"
        case .ratio5_7: s = "5:7"
        case .ratio4_3: s = "4:3"
        case .ratio3_5: s = "3:5"
        case .ratio3_2: s = "3:2"
        case .circle: s = "Circle"
        case .rectangle: s = "Rectangle"
        case .custom(let cGSize): s = "Custom \(Int(cGSize.width))X\(Int(cGSize.height))"
        }
        return s
    }
    
    public func size() -> CGSize{
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let maxWidth = screenWidth * 0.85
        let maxHeight = screenHeight * 0.7
        
        switch self {
        case .original:
            // Returns screen-fitting size, will need image dimensions in practice
            return .init(width: maxWidth, height: maxHeight)
        case .freeform:
            // User can freely adjust, start with a reasonable default
            return .init(width: maxWidth, height: maxHeight * 0.8)
        case .square:
            return .init(width: maxWidth, height: maxWidth)
        case .ratio16_9:
            let height = maxWidth * (9.0 / 16.0)
            return .init(width: maxWidth, height: height)
        case .ratio4_5:
            let height = maxWidth * (5.0 / 4.0)
            return .init(width: maxWidth, height: height)
        case .ratio5_7:
            let height = maxWidth * (7.0 / 5.0)
            return .init(width: maxWidth, height: height)
        case .ratio4_3:
            let height = maxWidth * (3.0 / 4.0)
            return .init(width: maxWidth, height: height)
        case .ratio3_5:
            let height = maxWidth * (5.0 / 3.0)
            return .init(width: maxWidth, height: height)
        case .ratio3_2:
            let height = maxWidth * (2.0 / 3.0)
            return .init(width: maxWidth, height: height)
        case .circle:
            return .init(width: maxWidth, height: maxWidth)
        case .rectangle:
            let height = maxWidth * 1.5
            return .init(width: maxWidth, height: height)
        case .custom (let cGSize):
            return cGSize
        }
    }
}
