//
//  StringRow.swift
//  FitWrench
//
//  Created by Aaron Anthony on 2023-05-06.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

public struct StringRow: View {

    let name: String
    @Binding var value: String
    //@Binding var isValid: Bool
    @FocusState var isActive: Bool

    public init(name: String, value: Binding<String>) {
        self.name = name
        self._value = value
    }
    
    public var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            TextField("", text: $value)
                .focused($isActive)
                .multilineTextAlignment(.trailing)
                .autocorrectionDisabled(true)
                .textFieldStyle(.roundedBorder)
                .frame(width: UIScreen.width / 2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isActive.toggle()
        }
    }
}

@available(iOS 17.0, *)
struct StringRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State private var value = ""
        @State private var isValid = false
        @State var dbl: Double = 33
        
        var body: some View {
            NavigationStack {
                List {
                    Section(header: Text("Inheritance"), footer: Text("is")) {
                        StringRow(name: "Name", value: .constant("Aaron"))
                        StringRow(name: "Game", value: .constant(""))
                        StringRow2(name: "Custom View", value: $value, isValid: $isValid) {
                            // Replace the following with your desired custom view
                            Color.red.frame(height: 40)
                        }
                        
                        StringRow3(name: "StringRow3", value: $value, isValid: $isValid) {
                            // Replace the following with your desired custom view
                            TextField("StringRow3", text: $value)
                                //.focused($isActive)
                                .multilineTextAlignment(.trailing)
                                .textFieldStyle(.roundedBorder)
                                .font(.body)
                                .frame(width: UIScreen.width / 2)
                        }
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("String Rows")
            }
        }
    }
}

@available(iOS 17.0, *)
public struct StringRow2<Content: View>: View {
    let name: String
    @Binding var value: String
    @Binding var isValid: Bool
    @FocusState var isActive: Bool
    let content: () -> Content

    public init(name: String, value: Binding<String>, isValid: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.name = name
        _value = value
        _isValid = isValid
        self.content = content
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text("Is Valid: \(isValid.description)")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            content()
                .frame(width: UIScreen.width / 2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isActive.toggle()
        }
        .onChange(of: value) {
            isValid = validate(value)
        }
    }
    
    private func validate(_ newValue: String) -> Bool {
        // Perform your validation logic here
        // Return true if the new value is valid, false otherwise
        return true
    }
}

@available(iOS 17.0, *)
public struct StringRow3<Value: Hashable, Content: View>: View {
    let name: String
    @Binding var value: Value
    @Binding var isValid: Bool
    @FocusState var isActive: Bool
    let content: () -> Content

    public init(name: String, value: Binding<Value>, isValid: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.name = name
        _value = value
        _isValid = isValid
        self.content = content
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                
                Text("Is Valid: \(isValid.description)")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            content()
                .frame(width: UIScreen.width / 2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isActive.toggle()
        }
        .onChange(of: value) {
            isValid = validate(value)
        }
    }
    
    private func validate(_ newValue: Value) -> Bool {
        // Perform your validation logic here
        // Return true if the new value is valid, false otherwise
        return true
    }
}
