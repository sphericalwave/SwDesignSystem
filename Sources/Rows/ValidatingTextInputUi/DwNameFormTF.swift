//
//  DwNameFormTF.swift
//  Dwellify
//
//  Created by Aaron Anthony on 2022-01-27.
//

import SwiftUI

//TODO: Fix this up or dispose of it
@available(iOS 14.0, *)
public struct DwNameFormTF: View {

    @Binding var textIn: String
    @Binding var valid: Bool
    let contentType: UITextContentType
    let color: Color = .blue1
    let label: String

    public init(textIn: Binding<String>, valid: Binding<Bool>, contentType: UITextContentType, label: String) {
        self._textIn = textIn
        self._valid = valid
        self.contentType = contentType
        self.label = label
    }
    
    public var body: some View {
        HStack {
            
            Text(label)
                //.avenirFont(size: 12, color: clr, type: .demiBold)
                .textCase(.lowercase)
            
            TextField(placeholder, text: $textIn)
                .keyboardType(.alphabet)
                //.avenirFont(size: 14, color: color, type: .bold)
                //.textFieldStyle(.roundedBorder)
                .textContentType(contentType)
                .multilineTextAlignment(.trailing)
                //.textCase(.uppercase)
                
            if valid {
                DwValidIcon()
            }
            else {
                DwWarningIcon()
            }
        }
        .padding()
        .border(clr, width: 2)
        .background(Color.white)
        .cornerRadius(3)
    }
    
    var placeholder: String {
        var s = ""
        if contentType == .givenName { s = "First Name" }
        if contentType == .familyName { s = "Last Name" }
        return s
    }
    
    var clr: Color { valid ? color : .red }
}

@available(iOS 14.0, *)
struct DwNameFormTF_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DwNameFormTF(textIn: .constant(""), valid: .constant(false), contentType: .givenName, label: "Test")
            DwNameFormTF(textIn: .constant("Aaron"), valid: .constant(true), contentType: .givenName, label: "King")
            DwNameFormTF(textIn: .constant("Mcgrath"), valid: .constant(false), contentType: .familyName, label: "Universe")
            Spacer()
        }
        .padding()
        //.background{ DwBasketBackground().ignoresSafeArea()}
    }
}
