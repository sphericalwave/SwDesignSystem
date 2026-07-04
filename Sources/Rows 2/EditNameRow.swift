//
//  EditNameRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-01.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

//TODO: push into SwShared
public struct EditNameRow: View {

    @Binding var name: String
    var head = "Name"
    var sub = "Required"

    public init(name: Binding<String>, head: String = "Name", sub: String = "Required") {
        self._name = name
        self.head = head
        self.sub = sub
    }

    public var body: some View {
        
        HStack {
            
//            Image(systemName: "note.text")
//                .thumbnailImg(color: .blue1)
            PlaceholderImg(img: nil)
            
            VerticalRowDetailText(headline: head, subHeadline: sub)
            
            //EditNameRow prefer Cursor start at begining of tf
            TextField("", text: $name)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
                .autocorrectionDisabled(true)
                .font(.headline)
                //.accessibilityLabel("EditNameRowTF") //tags at the callers level work
        }
    }
}

struct EditNameRow_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        
        @State var name = "Aaron"
        @State var name2 = ""
        
        var body: some View {
            List {
                EditNameRow(name: $name, head: "Method", sub: "Optional")
                EditNameRow(name: $name2)
            }
        }
    }
}
