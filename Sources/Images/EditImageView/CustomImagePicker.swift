//
//  SelectImgUi.swift
//  PhotoCrop
//
//  Created by Aaron Anthony on 2023-05-27.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
fileprivate struct CustomImagePicker<Content: View>: View {
    
    var options: [CropMethod]
    @Binding var show: Bool
    @Binding var croppedImg: UIImage?
    var content: () -> Content
    @State private var photoItems: PhotosPickerItem?
    @State private var selectedImg: UIImage?
    @State private var showDialog: Bool = false
    @State private var selectedCrop: CropMethod = .square
    @State private var showCropView: Bool = false
    
    var body: some View {
        content()
            .photosPicker(isPresented: $show, selection: $photoItems, preferredItemEncoding: .automatic)
            .tint(.blue1) //seems to tint text in photoPicker
            .onChange(of: photoItems) {
                if let photoItems {
                    updateImg(item: photoItems)
                }
            }
            .fullScreenCover(isPresented: $showCropView, onDismiss: { selectedImg = nil } ) {
                CropView(crop: selectedCrop, img: selectedImg, aspectRatios: options) { croppedImg, status in
                    if let croppedImg {
                        self.croppedImg = croppedImg
                    }
                }
            }
    }
    
    //TODO: seems to work
    //https://www.hackingwithswift.com/quick-start/concurrency/how-to-create-and-use-task-local-values
    func updateImg(item: PhotosPickerItem) {
        Task {
            if let data = try? await photoItems?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImg = uiImage
                }
            }
        }
        
        Task {
            showCropView.toggle()
        }
    }
}

@available(iOS 17.0, *)
extension View {
    
    @ViewBuilder
    func cropImagePicker(options: [CropMethod], show: Binding<Bool>, croppedImg: Binding<UIImage?>) -> some View {
        CustomImagePicker(options: options, show: show, croppedImg: croppedImg) {
            self
        }
    }
    
    @ViewBuilder
    func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
    
    func haptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

@available(iOS 17.0, *)
struct CustomImgPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State var isShowingPicker: Bool = false
        @State var croppedImg: UIImage?
        
        var hdr: some View {
            HStack {
                Spacer()
                EditImageView(croppedImg: $croppedImg)
                Spacer()
            }
            .chartBackgroundMod()
            .headerBackgroundMod()
        }
        var body: some View {
            NavigationStack {
                List {
                    Section(header: hdr) {
                        Text("Test")
                        Button(action: { isShowingPicker.toggle() }) {
                            Text("Tap")
                        }
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("test")
            }
        }
    }
}

//func fetchImages() async throws -> [UIImage] {
//    // .. perform data request
//}


