//
//  File.swift
//  SwShared
//
//  Created by Aaron McGrath on 2025-12-06.
//

import SwiftUI

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var scale: Double? = 1.0
    List {
        ScaleRow(name: "scale", scale: $scale)
    }
    .listStyle(.grouped)
}

@available(iOS 16.0, *)
public struct ScaleRow: View {
    @Binding var scale: Double?
    let name: String
    
    public init(name: String, scale: Binding<Double?>) {
        self._scale = scale
        self.name = name
    }
    
    public var body: some View {
        HStack {
            Text(name).font(.headline)
            Spacer()
            //TextField("0.0", text: $vm.scaleStr)
            TextField("1.0", value: $scale, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 100)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .font(.subheadline)
                .accessibilityIdentifier("ScaleRow-textField")
        }
    }
}
