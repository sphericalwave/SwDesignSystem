//
//  FdGearBtn.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2020-06-04.
//  Copyright © 2020 SphericalWave. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct NavBtn: View {
    
    let type: BtnType
    var color: Color
    var action: (() -> Void)?
    
    public init(type: BtnType, color: Color = .white, action: ( () -> Void)? = nil) {
        self.type = type
        self.color = color
        self.action = action
    }
    
    public var body: some View {
        Button(action: { action?() }) {
            VStack {
                if type == .plus {
                    Image(systemName: "plus.circle")
                        .thumbnailImg(color: color)
                }
                else if type == .edit {
                    Image(systemName: "gear")
                        .thumbnailImg(color: color)
                }
                else {
                    Image(systemName: "type.rawValue")
                        .thumbnailImg(color: color)
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct NavBtn_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                Text("Testing")
                
                BodyBtn(type: .edit) {
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        NavBtn(type: .edit) { }
                        NavBtn(type: .save) { }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavBtn(type: .plus) { }
                }
            }
        }
    }
}


