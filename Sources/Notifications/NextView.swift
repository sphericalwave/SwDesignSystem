//
//  NextView.swift
//  fu3l
//
//  Created by Aaron Anthony on 2023-10-09.
//  Copyright © 2021 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public enum NextView: String, Identifiable {
    case promo, renew
    public var id: String {
        self.rawValue
    }

    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .promo:
            Text("Promotional Offer")
                .font(.largeTitle)
        case .renew:
            VStack {
                Text("Renew Subscription")
                    .font(.largeTitle)
               Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 128))
            }
        }
    }
}

