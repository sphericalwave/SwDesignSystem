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
    
    var img: UIImage?
    var fallback: String = "photo"
    private let size = UIScreen.width / 9
    
    public init(img: UIImage?) {
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
            Image(uiImage: img)
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
                    PlaceholderImg(img: UIImage(named: "AppIcon"))
                    VerticalRowDetailText(headline: "PlaceholderImg", subHeadline: "Test")
                }
                
                HStack {
                    PlaceholderImg(img: UIImage(named: "wtr_vortex"))
                    VerticalRowDetailText(headline: "PlaceholderImg", subHeadline: "Test")
                }
                
                Text(UIScreen.width.formatted())
                
                Text((UIScreen.width / 9).formatted())
                
                Text(UIScreen.height.formatted())
            }
            .listStyle(.grouped)
            .navigationTitle("PlaceholderImg")
        }
    }
}
