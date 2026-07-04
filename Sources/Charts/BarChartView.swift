//
//  BarChartView.swift
//  CrtFdTests
//
//  Created by Aaron Anthony on 2023-10-02.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

//struct BarChartView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct BarChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarChartView()
//    }
//}

import SwiftUI

public struct BarChartView: View {
    public init() { }

    public var body: some View {
        HStack(spacing: 10) {
            BarView(value: 0.5, color: Color.blue)
            BarView(value: 0.8, color: Color.green)
            BarView(value: 0.6, color: Color.orange)
        }
    }
}

public struct BarView: View {
    var value: CGFloat
    var color: Color

    public init(value: CGFloat, color: Color) {
        self.value = value
        self.color = color
    }

    public var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 30, height: value * 200)
                .foregroundColor(color)
//            Text(String(format: "%.1f", value))
//                .font(.footnote)
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
}

