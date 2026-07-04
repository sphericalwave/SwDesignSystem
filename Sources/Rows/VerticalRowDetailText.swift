//
//  VerticalRowDetailText.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-09-26.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct VerticalRowDetailText: View {
    
    let head: String
    let sub: String
    let desc2: String?
    let alignment: HorizontalAlignment
    
    public init(headline: String, subHeadline: String, desc2: String? = nil ,alignment: HorizontalAlignment = .leading) {
            self.head = headline
            self.sub = subHeadline
        self.desc2 = desc2
            self.alignment = alignment
        }
    
    public var body: some View {
        VStack(alignment: alignment) {
            
            Text(head).font(.headline)
            Text(sub)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let desc2 {
                Text(desc2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

@available(iOS 13.0, *)
struct VerticalRowDetailText_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HStack {
                Image(systemName: "checkmark.circle")
                    //.thumbnailImg(color: .red1)
                
                VerticalRowDetailText(headline: "Headline", subHeadline: "Subheadline", desc2: "test")
                    .background(Color.gray)
                    //.padding()
            }
        }
        .listStyle(.grouped)
    }
}
