//
//  ZeroPoint.swift
//  ZeroPoint
//
//  Created by Aaron Anthony on 2020-09-02.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
public struct ZeroPointSpin: View {
        
    public init() {}
    
    public var body: some View {

        TimelineView(.animation) { timeline in
            let seconds = timeline.date.timeIntervalSinceReferenceDate
            let degrees = seconds.truncatingRemainder(dividingBy: 60.0) / 60.0 * 360.0
            
            Image("vectorEqNoBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 0, z: 1))
        }
    }
}
