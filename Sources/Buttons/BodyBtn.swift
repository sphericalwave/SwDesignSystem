//
//  SwiftUIView.swift
//  
//
//  Created by Aaron Anthony on 2023-10-21.
//

import SwiftUI

@available(iOS 13.0, *)
public struct BodyBtn: View {
    
    let type: BtnType
    var action: (() -> Void)?
    
    public init(type: BtnType, action: ( () -> Void)? = nil) {
        self.type = type
        self.action = action
    }
    
    public var body: some View {
        Button(action: { action?() }) {
            VStack {
                if type == .plus {
                    Image(systemName: "plus")
                        .resizable()
                        //.foregroundColor(.white)
                }
                else if type == .edit {
                    Image(systemName: "gear")
                        .resizable()
                        //.frame(width: 33, height: 33)
                        //.foregroundColor(.white)
                }
                else {
                    Image(systemName: "type.rawValue")
                        .resizable()
                        //.frame(width: 33, height: 33)
                        .frame(maxWidth: .infinity)
                }
            }
            .foregroundColor(.primary)
            .frame(width: 25, height: 25)
        }
    }
}
