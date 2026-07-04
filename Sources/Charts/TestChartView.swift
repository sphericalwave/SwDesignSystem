//
//  TestChartView.swift
//  suit
//
//  Created by Aaron Anthony on 2023-02-19.
//


//TODO: move into charts project

import SwiftUI
import Charts

public struct Workout2: Identifiable {
    public let id = UUID()
    let day: String
    let minutes: Int

    public init(day: String, minutes: Int) {
        self.day = day
        self.minutes = minutes
    }
}

extension Workout2 {
    static let volume: [Workout2] = [
        .init(day: "Mon", minutes: 23),
        .init(day: "Tue", minutes: 35),
        .init(day: "Wed", minutes: 55),
        .init(day: "Thu", minutes: 30),
        .init(day: "Fri", minutes: 15),
        .init(day: "Sat", minutes: 65),
        .init(day: "Sun", minutes: 81),
    ]
    
    static let strength: [Workout2] = [
        .init(day: "Mon", minutes: 16),
        .init(day: "Tue", minutes: 12),
        .init(day: "Wed", minutes: 55),
        .init(day: "Thu", minutes: 34),
        .init(day: "Fri", minutes: 22),
        .init(day: "Sat", minutes: 43),
        .init(day: "Sun", minutes: 90),
    ]
}

@available(iOS 16.0, *)
public struct TestChartView: View {

    let workoutData = [
        (workoutType: "Volume", data: Workout2.volume),
        (workoutType: "Strength", data: Workout2.strength)
    ]

    public init() { }
    
    public var body: some View {
        ZStack {
            Chart {
                ForEach(workoutData, id: \.workoutType) { element in
                    ForEach(element.data) { workout in
                        BarMark(
                            x: .value("Day", workout.day),
                            y: .value("Workout(in minutes)", workout.minutes)
                        )
                        .foregroundStyle(by: .value("Workout(type)", element.workoutType))
                        .position(by: .value("Workout(type)", element.workoutType))
                    }
                }
            }
            
            Text("TestChartView")
                .foregroundStyle(.red)
        }
    }
}


@available(iOS 16.0, *)
struct TestChartView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TestChartView()
                .chartBackgroundMod()
                .headerBackgroundMod()
            Spacer()
        }
    }
}
