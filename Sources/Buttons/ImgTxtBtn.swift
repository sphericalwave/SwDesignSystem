//
//  ImgTxtBtn.swift
//  ZeroPoint
//
//  Created by Aaron Anthony on 2020-09-09.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ImgTxtBtn: View {

    let grad = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom)

    public init() { }
    
    public var body: some View {
        Button(action: {
            //self.uiRouter.permit()
            //self.loading.toggle()
        } ) {
            HStack {
                Image(systemName: "eye")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("an eye")
                    .fontWeight(.bold)
                    .font(.title)
            }
            .padding()
            .background(grad)
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(grad, lineWidth: 5)
            )
        }
    }
}
