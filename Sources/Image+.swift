//
//  Image+.swift
//  fu3l
//
//  Created by Aaron Anthony on 2022-07-06.
//  Copyright © 2022 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension Image {
    func myImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .clipShape(Circle())
    }
    
    func thumbnail() -> some View {
        self
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(9)
            .shadow(radius: 3)
    }
    
    func navIcon() -> some View { 
        self
            .font(.headline)
            .foregroundColor(.white)
    }
    
    func thumbnailImg(color: Color = .blue1, width: Double = 33, height: Double = 33) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(color)
            .frame(width: width, height: height)
            //.shadow(radius: 2)
    }
}
