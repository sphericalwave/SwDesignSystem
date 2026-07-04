//
//  InfiniteDateView.swift
//  GroundhogDay
//
//  Created by Aaron Anthony on 2024-10-22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct InfiniteDateView<Content: View>: View {
    
    @Binding public var currentDate: Date
    let content: (Date) -> Content
    
    public init(currentDate: Binding<Date>, content: @escaping (Date) -> Content) {
        self._currentDate = currentDate
        self.content = content
    }
    
    public var body: some View {
        InfinitePageView(selection: $currentDate,
                         before: before,
                         after: after,
                         view: { content($0) })
    }
    
    let before: (Date) -> Date = { date in
        Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
    }
    
    let after: (Date) -> Date = { date in
        Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
    }
}

//preview doesn't seem to be working
@available(iOS 15.0, *)
#Preview {

    struct Container: View {
        
        @State var date = Date()
        
        var body: some View {
            VStack {
                
                Text("Today is: \(date.formatted())")

                
                InfiniteDateView(currentDate: $date) { date in
                    VStack {
                        Text("Today is: \(date.formatted())")
                            .font(.largeTitle)
                            .padding()
                    }
                }
                .background(Color.blue)
            }
        }
    }
    
    return Container()
}
