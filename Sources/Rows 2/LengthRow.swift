//
//  LengthRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-10-06.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct LengthRow: View {

    @Binding var value: Double?
    @Binding var isInches: Bool
    let label: String
    let required: Bool

    public init(value: Binding<Double?>, isInches: Binding<Bool>, label: String, required: Bool) {
        self._value = value
        self._isInches = isInches
        self.label = label
        self.required = required
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "ruler")
                .thumbnailImg()
            
            //Text(label)
            VerticalRowDetailText(headline: label, subHeadline: required ? "Required": "Optional")
            Spacer()
            LengthTF(inches: $value, isInches: $isInches)
            
            //FIXME: remove?
            Text(isInches ? "in" : "cm") //debug
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct LengthRow_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State var v: Double?
        @State var isInches: Bool = false
        
        var body: some View {
            LengthRow(value: $v, isInches: $isInches, label: "Length", required: true)

        }
    }
}
