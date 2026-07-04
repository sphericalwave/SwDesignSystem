//
//  MenuBtn.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-17.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SubBtn: View {
    
    let name: String
    let icon: String
    var action: ( ()->Void )?
    
    public init(name: String, icon: String, action: ( () -> Void)? = nil) {
        self.name = name
        self.icon = icon
        self.action = action
    }
    
    public var body: some View {
        
        VStack {
            Text(name)
                .font(.footnote)
                .foregroundColor(.primary)
                .padding(.bottom, 9)
            
            Button(action: { action?() }) {
                Image(systemName: icon)
                //PJRPulseButton()
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                   .background(Circle().foregroundColor(.blue1).frame(width: 44, height: 44))
            }
        }
        //.background(.ultraThickMaterial, in: Circle())
    }
    
//    var background: some View {
//                LinearGradient(
//                    colors: [.red, .blue1],
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//    }
}

@available(iOS 16.0, *)
struct MenuBtn_Previews: PreviewProvider {
    
    struct Container: View {
        
        var body: some View {
            NavigationStack {
                HStack(spacing: 10) {
                    Spacer()
                    SubBtn(name: "Food", icon: "circle", action: {  })
                    Spacer()
                    SubBtn(name: "Suit", icon: "plus")
                    Spacer()
                    SubBtn(name: "Water", icon: "plus")
                    Spacer()
                    SubBtn(name: "Movement", icon: "plus")
                    Spacer()
                }
                .navigationTitle("Test")
            }
        }
    }
    
    static var previews: some View {
        Container()
    }
}
