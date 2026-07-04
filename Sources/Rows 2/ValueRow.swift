//
//  ScaleRow.swift
//  NewFdTests
//
//  Created by Aaron Anthony on 2023-05-01.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct ValueRow: View {

    let name: String
    @Binding var scale: String
    @FocusState var isFocused: Bool

    public init(name: String, scale: Binding<String>) {
        self.name = name
        self._scale = scale
    }
    
    public var body: some View {

        Text("ValueRow Fixme")
//        HStack(alignment: .center) {
//            VStack(alignment: .leading) {
//                Text(name)
//                    .font(.callout)
//
//                if !isScaleValid {
//                    Text("Required")
//                        .font(.footnote)
//                        .foregroundColor(.red)
//                }
//            }
//
//            Spacer()
//
//            TextField("scale!", text: $scale) //TODO: MsrmtSection : initial scale placeholder?
//                .numbersOnly($scale, includeDecimal: true)
//                .focused($isFocused)
//                .textFieldStyle(.roundedBorder)
//                .multilineTextAlignment(.trailing)
//                .font(.body)
//                .frame(maxWidth: UIScreen.width / 4)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {
//            isFocused = true
//        }
    }
    
    var isScaleValid: Bool {
        guard let s = Double(scale) else { return false }
        if s > 0 { return true }
        return false
    }
}

@available(iOS 16.0, *)
struct ScaleRow_Previews: PreviewProvider {
    
    struct Container: View {
        @State var scale: String //TODO: can this be a dbl, i think i've solved this in DoubleRow
        var body: some View {
            ValueRow(name: "Scale Row", scale: $scale)
        }
    }
    
    static var previews: some View {
        NavigationStack {
            List {
                Section(header: Text("Testing")) {
                    Container(scale: "")
                    Container(scale: "")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Scale Row")
        }
    }
}
