//
//  SwDatePicker.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-21.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct SwDatePicker: View {
    @Binding var day: Date
    let components: DatePickerComponents  //[.date, .hourAndMinute]

    public init(day: Binding<Date>, components: DatePickerComponents) {
        self._day = day
        self.components = components
    }
    
    public var body: some View {
        DatePicker("", selection: $day, displayedComponents: components)
            .environment(\.colorScheme, .dark)
            .tint(.blue1)
    }
}

@available(iOS 16.0, *)
struct SwDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationStack {
            List {
                Container(day: Date(), components: [.date, .hourAndMinute])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Container(day: Date(), components: [.date])
                }
            }
            .listStyle(.grouped)
            .navigationTitle("SwDatePicker")
        }
        .tint(.white)
    }
    
    struct Container: View {        
        @State var day: Date
        let components: DatePickerComponents
        
        var body: some View {
            SwDatePicker(day: $day, components: components)
        }
    }
}

