//
//  BodyFatRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-10-06.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct BodyFatRow: View {

    @Binding var bodyfat: Double?

    public init(bodyfat: Binding<Double?>) {
        self._bodyfat = bodyfat
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "compass.drawing")
                .thumbnailImg(color: .green)
            
            VerticalRowDetailText(headline: "BodyFat", subHeadline: "Optional")
            DoubleTF(double: $bodyfat, placeholder: "BodyFat")
            
            Text("%")
        }
    }
}

struct BodyFatRow_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State var b: Double?
        
        var body: some View {
            BodyFatRow(bodyfat: $b)

        }
    }
}
