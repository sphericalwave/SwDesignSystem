//
//  File.swift
//  SwShared
//
//  Created by Aaron McGrath on 2025-12-03.
//

import SwiftUI

@available(iOS 16.0, *)
#Preview {
    NavigationStack {
        List {
            Section(header: PlaceholderHdr(text: "Testing123")) {
                Text("Testing")
            }
        }
        .listStyle(.grouped)
        .navigationTitle("PlaceholderHdr")
    }
}

@available(iOS 15.0, *)
public struct PlaceholderHdr: View {
    
    let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        ZStack {
            //dunno why no appear in preview works in fw
            ZeroPointSpin()
                .opacity(0.3)

            Text(text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            

        }
        .chartHeader()
    }
}
