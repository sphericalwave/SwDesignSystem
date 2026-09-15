//
//  PlaceholderImg.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-10-13.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

//Used everywhere
@available(iOS 15.0, *)
public struct PlaceholderImg: View {
    
    var img: PlatformImage?
    var fallback: String = "photo"
    private let size = SwScreen.width / 9
    
    public init(img: PlatformImage?) {
        self.img = img
    }
    
    public var body: some View {
        imageContent
            .scaledToFit()
            .frame(width: size, height: size)
            .cornerRadius(SwTheme.cornerRadius)
    }
    
    @ViewBuilder
    private var imageContent: some View {
        if let img = img {
            Image(platformImage: img)
                .resizable()
        } else {
            Image(systemName: fallback)
                .resizable()
                .foregroundStyle(.secondary)
        }
    }
}

@available(iOS 16.0, *)
struct PlaceholderImg_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            List {
                HStack {
                    PlaceholderImg(img: nil)
                    VerticalRowDetailText(headline: "PlaceholderImg", subHeadline: "Test")
                }
                
                HStack {
                    PlaceholderImg(img: PlatformImage(named: "AppIcon"))
                    VerticalRowDetailText(headline: "PlaceholderImg", subHeadline: "Test")
                }
                
                HStack {
                    PlaceholderImg(img: PlatformImage(named: "wtr_vortex"))
                    VerticalRowDetailText(headline: "PlaceholderImg", subHeadline: "Test")
                }
                
                Text(SwScreen.width.formatted())
                
                Text((SwScreen.width / 9).formatted())
                
                Text(SwScreen.height.formatted())
            }
            .swGroupedList()
            .navigationTitle("PlaceholderImg")
        }
    }
}
