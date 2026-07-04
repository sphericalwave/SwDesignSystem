//
//  TempChart.swift
//  CrtFdTests
//
//  Created by Aaron Anthony on 2023-10-02.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct TempChart: View {

    let comment: String

    public init(comment: String) {
        self.comment = comment
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: "chart.bar.fill")
                        .thumbnailImg(color: .red1)
                    
                    Text(comment)
                    Spacer()
                }
                .frame(maxHeight: .infinity)
        }
        .chartBackgroundMod()
        .headerBackgroundMod()
    }
}

@available(iOS 16.0, *)
struct TempChart_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                Section(header: TempChart(comment: "Test Comment")) {
                    
                }
            }
            .listStyle(.grouped)
            .navigationTitle("TempChart")
        }
    }
}
