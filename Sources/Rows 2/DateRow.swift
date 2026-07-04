//
//  DateRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-08.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct DateRow: View {

    @Binding var date: Date
    let label: String
    let components: DatePickerComponents
    @FocusState private var isDatePickerActive: Bool

    public init(date: Binding<Date>, label: String, components: DatePickerComponents = [.date, .hourAndMinute]) {
            self._date = date
            self.label = label
            self.components = components
        }
    
    public var body: some View {

        HStack {
            Image(systemName: "calendar.circle")
                .thumbnailImg(color: .red1)
            
            VStack(alignment: .leading) {
                Text(label)
                    .foregroundColor(.primary)
//                if !suit.birthdateIsValid {
//                    Text("required")
//                        .font(.caption)
//                        .foregroundColor(.red)
//                }
            }
            Spacer()
            
            SwDatePicker(day: $date, components: components)
                .labelsHidden()
        }
        .contentShape(Rectangle())
//        .onTapGesture {
//            isDatePickerActive = true
//        }
    }
}

struct DateRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DateRow(date: .constant(Date()), label: "Birthday")
            DateRow(date: .constant(Date()), label: "Birthday", components: [.date])
        }
        .listStyle(.grouped)
    }
}
