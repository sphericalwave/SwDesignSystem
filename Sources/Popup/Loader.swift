//
//  Loader.swift
//  PopupSwiftUI
//
//  Created by Vadim Bulavin on 04.02.2021.
//

import SwiftUI

public struct Loader: View {
    public init() { }

    public var body: some View {
        Group {
            ProgressView("Loading…")
                .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
        }
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
}

