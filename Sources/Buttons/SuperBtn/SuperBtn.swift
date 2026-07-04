//
//  PlusBtn2.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-17.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SuperBtn: View {
    
    //@State var isActive = false
    let btns: [SubBtn]  // Updated property type
    @Binding var isExpanded: Bool
    var action: (() -> Void)?
    
    public init(btns: [SubBtn], isExpanded: Binding<Bool>, action: ( () -> Void)? = nil) {
        self.btns = btns
        self._isExpanded = isExpanded
        self.action = action
    }
    
    public var body: some View {
       // ZStack {
            
            // if isExpanded {
            
            VStack {
                Spacer()
                
                ZStack {
                    ForEach(btns.indices, id: \.self) { index in
                        btns[index]
                            .opacity(isExpanded ? 1 : 0)
                            .shadow(radius: 9)
                            .offset(offset(index: index))
                            .animation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 1).delay(Double(index) * 0.15), value: isExpanded)
                    }
                    
                    
                    Button(action: tap) {
                        Image(systemName: "plus")
                            .font(.system(size: 45, weight: .regular, design: .default))
                            .foregroundColor(isExpanded ? .white: .blue1)
                            .frame(width: 66, height: 66)
                            .background(
                                Circle()
                                    .foregroundColor(isExpanded ? .red : .white)
                                //.border(Color.blue1, width: 1)
                                    .shadow(radius: 9)
                            )
                            .rotationEffect(isExpanded ? Angle(degrees: 45): .zero)
                        //.animation(.easeInOut)
                    }
                }
            }
        //}
    }
    
    func tap() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.35, blendDuration: 3) ) {
            isExpanded.toggle()
        }
        action?()
    }
    
    func offset(index: Int) -> CGSize {
        let angleAboveHorizontal: Double = 33
        let radius: Double = 160
        let angleBetween: Double = (180 - (2 * angleAboveHorizontal)) / Double(btns.count - 1)
        let rotation = Double(180 + angleAboveHorizontal)
        
        if isExpanded {
            let x = CGFloat(cos((Double(index) * angleBetween + rotation) * Double.pi / 180) * radius)
            let y = CGFloat(sin((Double(index) * angleBetween + rotation) * Double.pi / 180) * radius)
            
            return CGSize(width: x, height: y)
        }
        
        return .zero
    }
}

@available(iOS 16.0, *)
struct PlusBtn2_Previews: PreviewProvider {
    struct Container: View {
        @State var isMenuOpen: Bool
        
        var body: some View {
            NavigationStack {
                VStack {
                    let b1 = SubBtn(name: "Food", icon: "circle", action: {  })
                    let b2 = SubBtn(name: "Suit", icon: "plus")
                    let b3 = SubBtn(name: "Water", icon: "plus")
                    let b4 = SubBtn(name: "Movement", icon: "plus")
                    
                    Spacer()
                    SuperBtn(btns: [b1, b3, b2, b4], isExpanded: $isMenuOpen)
                }
            }
        }
    }
    
    static var previews: some View {
        Container(isMenuOpen: true)
    }
}
