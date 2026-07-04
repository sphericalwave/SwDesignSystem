//
//  ChckBtn.swift
//  FitWrenchData
//
//  Created by Aaron Anthony on 2020-08-12.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

//this btn depends on 
@available(iOS 13.0, *)
public struct CheckBtn: View {
    
    @Binding var check: Bool
    var action: (() -> Void)?
    
    public init(check: Binding<Bool>, action: ( () -> Void)? = nil) {
        self._check = check
        self.action = action
    }
    
    public var body: some View {
        Button(action: tap) {
            Image(systemName: check ? "checkmark.circle" : "circle")
                //TODO: bigger mod .thumbnailImg(color: check ? .blue1 : .secondary)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(check ? .blue1 : .secondary)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func tap() {
        withAnimation {
            check.toggle()
            //if check {
                action?()
            //}
        }
    }
}
