//
//  BirthdayRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2024-08-07.
//  Copyright © 2024 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct BirthdayRow: View {

    @Binding var birthday: Date

    public init(birthday: Binding<Date>) {
        self._birthday = birthday
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "calendar.circle")
                .thumbnailImg(color: .red1)
            
            VerticalRowDetailText(headline: "Birthday", subHeadline: "Required")
            
            Spacer()
            DatePicker("", selection: $birthday, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.compact)
                .tint(.blue1)
        }
    }
}

//#Preview {
//    @State var b: Date = .the_matrix
//    return List {
//        BirthdayRow(birthday: $b)
//    }
//}
