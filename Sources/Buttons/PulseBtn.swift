//
//  PulseBtn.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-12.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

// MARK: - Strucutre for Circle
public struct CircleData: Hashable {
    let width: CGFloat
    let opacity: Double

    public init(width: CGFloat, opacity: Double) {
        self.width = width
        self.opacity = opacity
    }
}

@available(iOS 13.0, *)
public struct PJRPulseButton: View {
    
    // MARK: - Properties
    @State private var isAnimating: Bool = false
    var color: Color
    var systemImageName: String
    var buttonWidth: CGFloat
    var numberOfOuterCircles: Int
    var animationDuration: Double
    var circleArray = [CircleData]()


    public init(color: Color = Color.blue, systemImageName: String = "plus.circle.fill",  buttonWidth: CGFloat = 48, numberOfOuterCircles: Int = 2, animationDuration: Double  = 1) {
        self.color = color
        self.systemImageName = systemImageName
        self.buttonWidth = buttonWidth
        self.numberOfOuterCircles = numberOfOuterCircles
        self.animationDuration = animationDuration
        
        var circleWidth = self.buttonWidth
        var opacity = (numberOfOuterCircles > 4) ? 0.40 : 0.20
        
        for _ in 0..<numberOfOuterCircles{
            circleWidth += 20
            self.circleArray.append(CircleData(width: circleWidth, opacity: opacity))
            opacity -= 0.05
        }
    }

    // MARK: - Body
    public var body: some View {
        ZStack {
            Group {
                ForEach(circleArray, id: \.self) { cirlce in
                    Circle()
                            .fill(self.color)
                        .opacity(self.isAnimating ? cirlce.opacity : 0)
                        .frame(width: cirlce.width, height: cirlce.width, alignment: .center)
                        .scaleEffect(self.isAnimating ? 1 : 0)
                }
            }
            .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true),
               value: self.isAnimating)

            Button(action: {
                print("Button Pressed event")
            }) {
                Image(systemName: self.systemImageName)
                    .resizable()
                    .scaledToFit()
                    .background(Circle().fill(Color.white))
                    .frame(width: self.buttonWidth, height: self.buttonWidth, alignment: .center)
                    .accentColor(color)
                
            }
            .onAppear(perform: {
                self.isAnimating.toggle()
            })
        } //: ZSTACK
    }
}

@available(iOS 13.0, *)
struct PulseButton_Previews: PreviewProvider {
    static var previews: some View {
        PJRPulseButton()
    }
}
