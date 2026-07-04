//
//  CircleProgress.swift
//  ZeroPoint
//
//  Created by Aaron Anthony on 2021-05-22.
//  Copyright © 2021 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct CircularProgressView: View {
    
    @Binding var pgrs: Float  //Int is 16bit, float is 32,
    private let w: CGFloat
    private let color: Color
    
    public init(pgrs: Binding<Float>, width: CGFloat = 6, color: Color = .blue) {
        self._pgrs = pgrs
        self.color = color
        self.w = width
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: w)
                .opacity(0.3)
                .foregroundColor(color)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.pgrs, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: w, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

@available(iOS 15.0, *)
struct CircleProgress_Previews: PreviewProvider {
    static var previews: some View {
        Container(progress: 0.33)
    }
    
    struct Container: View {
        
        @State var progress: Float
        
        var body: some View {
            VStack {
                ZStack {
                    VStack {
                        CircularProgressView(pgrs: $progress, width: 3)
                        
                        
                        CircularProgressView(pgrs: $progress, width: 10)
                            .padding()
                        
                        Text(progress.formatted()).font(.title)
                    }
                }
                
                //FIXME: stepper stutters and doesn't change sometimes?
                Stepper("Progress",
                        onIncrement: { self.progress += 0.1 },
                        onDecrement: { self.progress -= 0.1 })
            }
            .padding()
        }
    }
}
