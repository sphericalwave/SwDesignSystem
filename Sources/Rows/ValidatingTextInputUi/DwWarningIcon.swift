//
//  DwWarningIcon.swift
//  ContractorPortal
//
//  Created by Aaron Anthony on 2021-11-19.
//

import SwiftUI

@available(iOS 13.0, *)
public struct DwWarningIcon: View {
    public init() { }

    public var body: some View {
        Image(systemName: "exclamationmark.circle.fill")
            .resizable()
            .foregroundColor(.red)
            .frame(width: 20, height: 20)
    }
}

@available(iOS 13.0, *)
public struct DwValidIcon: View {
    public init() { }

    public var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(.blue1)
            .frame(width: 20, height: 20)
    }
}
