//
//  SwTextEditor.swift
//  FitWrench
//
//  Created by Aaron McGrath on 2025-08-10.
//  Copyright © 2025 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct SwTextEditor: View {

    let desc: String
    @Binding var comment: String

    public init(desc: String, comment: Binding<String>) {
        self.desc = desc
        self._comment = comment
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(desc)
                //.font(.title3)
                //.foregroundStyle(Color.blue1) //SwShared
                .padding(.bottom, 3)
            
            TextEditor(text: $comment)
                .frame(minHeight: UIScreen.height / 9)
                .cornerRadius(9)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.secondary, lineWidth: 1)
                )
                .padding(.bottom, 9)
        }
    }
}

#Preview {
    List {
        SwTextEditor(desc: "Comment",
                     comment: .constant("Testing"))
    }
}
