//
//  FdChartDatum.swift
//  fu3l
//
//  Created by Aaron Anthony on 2022-12-07.
//  Copyright © 2022 SphericalWaveSoftware. All rights reserved.
//

import Foundation

public struct ChartDatum: Identifiable {
    public let id = UUID()
    public let date: Date
    public let value: Double

    public init(date: Date, steps: Double) {
        self.date = date
        self.value = steps
    }
}
