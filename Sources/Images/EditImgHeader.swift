//
//  EditImgHeader.swift
//  CrtFdTests
//
//  Created by Aaron Anthony on 2023-10-02.
//  Copyright © 2023 SphericalWaveSoftware. All rights reserved.
//

import SwiftUI

//Used All Over
@available(iOS 17.0, *)
public struct EditImgHeader: View {

    @Binding var img: UIImage?

    public init(img: Binding<UIImage?>) {
        self._img = img
    }
    
    public var body: some View {
        EditImageView(croppedImg: $img)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            //.chartHeader()
            .font(.subheadline)
            .foregroundColor(.primary)
            //.padding()
            .background(.ultraThinMaterial)
            .cornerRadius(SwTheme.cornerRadius)
            .shadow(radius: SwTheme.shadowRadius)
            //.textCase(nil)
            .padding(SwTheme.bottomPadding)
            .frame(height: UIScreen.height / 4 + 50) //avoid paging indicators //TODO: standardize
            .background(SwGradient())
            .listRowInsets(EdgeInsets()) //prevent squashing via List'
    }
}

@available(iOS 17.0, *)
struct EditImgHeader_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                Section(header: EditImgHeader(img: .constant(nil))) {
                    Text("Test")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("test")
        }
    }
}
