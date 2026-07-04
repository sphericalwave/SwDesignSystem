//
//  SaveBtn.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-20.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public enum BtnType: Equatable {
    case save
    case plus
    case edit
    case custom(String)
    case next
}

@available(iOS 14.0, *)
public struct LrgBtn: View {
    
    let type: BtnType
    var isDisabled = false
    var didTap: (() -> Void)?
    @Environment(\.colorScheme) private var colorScheme
    
    public init(type: BtnType, isDisabled: Bool = false, didTap: ( () -> Void)? = nil) {
        self.type = type
        self.isDisabled = isDisabled
        self.didTap = didTap
    }
    
    public var body: some View {
        Button(action: { if !isDisabled { didTap?() } }) {
            if let i = buttonProperties.image {
                i.thumbnailImg(color: isDisabled ? .secondary : colorScheme.buttonColor)
            }

            if let t = buttonProperties.text {
                Text(t)
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .foregroundColor(isDisabled ? .secondary : colorScheme.buttonColor)
            }
        }
        .disabled(isDisabled)
        .accessibilityLabel(accessibilityLabel)
    }
    
    private var accessibilityLabel: String {
        switch type {
        case .save: return "Save"
        case .plus: return "Add"
        case .edit: return "Edit"
        case .next: return "Next"
        case let .custom(text): return text
        }
    }

    private var buttonProperties: (image: Image?, text: String?) {
        switch type {
        case .save:
            return (Image(systemName: "square.and.arrow.down"), nil)
        case .plus:
            return (Image(systemName: "plus.circle"), nil)
        case .edit:
            return (Image(systemName: "pencil"), "Edit")
        case .next:
            return (Image(systemName: "arrow.right.square"), nil)
        case let .custom(text):
            return (nil, text)
        }
    }
}

@available(iOS 16.0, *)
struct SaveBtn_Previews: PreviewProvider {
    
    struct Container: View {
        @State var msg = "tapBtn"
        var body: some View {
            NavigationStack {
                List {
                    Text(msg)
                    
                    HStack {
                        LrgBtn(type: .edit, didTap: { msg = "didTap edit" })
                        Spacer()
                        LrgBtn(type: .edit, isDisabled: true) { msg = "didTap edit" }
                        
                    }
                    
                    LrgBtn(type: .plus, didTap: { msg = "didTap plus" })
                    
                    LrgBtn(type: .next, didTap: { msg = "didTap plus" })
                    
                    LrgBtn(type: .save, didTap: { msg = "didTap save" })
                    
                    
                    EditBtn() {  }
                    
                    DeleteBtn() {  }
                }
                .listStyle(.grouped)
                .navigationTitle("SaveBtn")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        LrgBtn(type: .custom("Add To Journal"), didTap: { msg = "didTap save" })
                            .buttonStyle(.bordered)

                    }
                }
            }
        }
    }
    
    static var previews: some View {
        Container()
    }
}
