//
//  MassRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-10-06.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct MassRow: View {

    @Binding var value: Double?
    @Binding var isPounds: Bool
    let label: String
    let required: Bool

    public init(value: Binding<Double?>, isPounds: Binding<Bool>, label: String, required: Bool) {
        self._value = value
        self._isPounds = isPounds
        self.label = label
        self.required = required
    }
    
    public var body: some View {
        HStack {
            
            Image(systemName: "globe")
                .thumbnailImg(color: .red1)
            
            VerticalRowDetailText(headline: "Mass",
                                  subHeadline: required ? "Required": "Optional")
            
            Spacer()
            
            MassTF(pounds: $value, isPounds: $isPounds)
            
            Text(isPounds ? "ibs" : "kg")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct MassRow_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State var v: Double?
        @State var isPounds: Bool = false
        
        var body: some View {
            MassRow(value: $v, isPounds: $isPounds, label: "Mass", required: true)

        }
    }
}
