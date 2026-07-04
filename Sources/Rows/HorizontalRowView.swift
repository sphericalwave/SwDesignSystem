//
//  HorizontalRowDetailView.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-10-04.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct HorizontalDetailView: View {
    
    let head: String
    let sub: String
    
    public init(head: String, sub: String) {
        self.head = head
        self.sub = sub
    }
    
    public var body: some View {
        HStack {
            Text(head)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(sub)
                .foregroundColor(.primary)
                .font(.subheadline)
        }
    }
}

@available(iOS 13.0, *)
struct HorizontalRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDetailView(head: "Aaron", sub: "I love You!")
            .background(Color.gray)
            .padding()
    }
}
