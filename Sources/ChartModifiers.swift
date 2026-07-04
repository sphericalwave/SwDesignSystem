//
//  ChartModifiers.swift
//  SwShared
//
//  Created by Aaron Anthony on 2023-06-27.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
public extension View {
    
    func chartHeader() -> some View {
        self
            .chartBackgroundMod()
            .headerBackgroundMod()
    }
    
    func chartBackgroundMod() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(.primary)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(SwTheme.cornerRadius)
            .shadow(radius: SwTheme.shadowRadius)
            .textCase(nil)
    }
    
    //rename...groupedListHdrBackground
    func headerBackgroundMod() -> some View {
        self
            .padding(SwTheme.bottomPadding)
            .frame(height: UIScreen.height / 4 + 50) //avoid paging indicators
            .background(SwGradient())
            .listRowInsets(EdgeInsets()) //prevent squashing via List
    }
    
    func listHeader() -> some View {
        self
            .chartBackgroundMod()
            .padding(SwTheme.bottomPadding)
            //.frame(height: UIScreen.height / 4 + 50) //avoid paging indicators
            .background(SwGradient())
            .listRowInsets(EdgeInsets()) //prevent squashing via List
    }
}
