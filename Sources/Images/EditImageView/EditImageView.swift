//
//  SelectableImgUi.swift
//  PhotoCrop
//
//  Created by Aaron Anthony on 2023-05-27.
//

import SwiftUI
import AVFoundation
import PhotosUI

@available(iOS 17.0, *)
public struct EditImageView: View {

    @State private var isShowingPicker: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var showCamera: Bool = false
    @State private var showImageEditor: Bool = false
    @Binding var croppedImg: UIImage?

    public init(croppedImg: Binding<UIImage?>) {
        self._croppedImg = croppedImg
    }
    
    public var body: some View {
        VStack {
            if let croppedImg {
                Image(uiImage: croppedImg)
                    .resizable()
                    .scaledToFit()
                    //.cornerRadius(9)
                    //.shadow(radius: 9)
            }
            else {
                ZStack {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.secondary)
                }
            }
        }
        .accessibilityLabel("SelectableImgUi")
        .contentShape(Rectangle())
        .listRowInsets(EdgeInsets())
        .onTapGesture {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { status in
                    showActionSheet = true
                }
            default: showActionSheet = true
            }
        }
        .cropImagePicker(options: CropMethod.allCases(), show: $isShowingPicker, croppedImg: $croppedImg)
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(camera: CameraModel(img: $croppedImg, isShowingCamera: $showCamera)) //TODO: needs a binding img
        }
        .sheet(isPresented: $showImageEditor) {
            ImageEditorView(image: $croppedImg)
        }
        .confirmationDialog("Attach Photo", isPresented: $showActionSheet, titleVisibility: .visible) {
            generateDialogButtons()
                .textCase(nil)
        }
    }
    
    //TODO: need one without take picture btn
    @ViewBuilder
    func generateDialogButtons() -> some View {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            Button("Take a Photo") {
                showCamera = true
            }
        default:
            EmptyView()
        }
        
        Button("Choose from Photos") {
            isShowingPicker = true
        }
        
        if croppedImg != nil {
            Button("Edit Photo") {
                showImageEditor = true
            }
            
            Button("Remove Photo", role: .destructive) {
                croppedImg = nil
            }
        }
        
        Button("Cancel", role: .cancel) {}
    }
}

// MARK: - Image Editor View
@available(iOS 17.0, *)
struct ImageEditorView: View {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedAspectRatio: CropMethod = .square
    @State private var showPhotoPicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @AppStorage("defaultAspectRatio") private var defaultAspectRatioRaw: String = "square"
    
    private let availableAspectRatios: [CropMethod] = CropMethod.allCases()
    
    var body: some View {
        if let image {
            CropView(crop: selectedAspectRatio, img: image, aspectRatios: availableAspectRatios) { croppedImg, status in
                if let croppedImg, status {
                    self.image = croppedImg
                }
                dismiss()
            }
            .onAppear {
                selectedAspectRatio = loadDefaultAspectRatio()
            }
        } else {
            NavigationStack {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    Text("No image selected")
                        .foregroundColor(.white)
                }
                .navigationTitle("Edit Photo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.black, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
    
    private func saveDefaultAspectRatio(_ aspectRatio: CropMethod) {
        switch aspectRatio {
        case .original:
            defaultAspectRatioRaw = "original"
        case .freeform:
            defaultAspectRatioRaw = "freeform"
        case .square:
            defaultAspectRatioRaw = "square"
        case .ratio16_9:
            defaultAspectRatioRaw = "ratio16_9"
        case .ratio4_5:
            defaultAspectRatioRaw = "ratio4_5"
        case .ratio5_7:
            defaultAspectRatioRaw = "ratio5_7"
        case .ratio4_3:
            defaultAspectRatioRaw = "ratio4_3"
        case .ratio3_5:
            defaultAspectRatioRaw = "ratio3_5"
        case .ratio3_2:
            defaultAspectRatioRaw = "ratio3_2"
        case .circle:
            defaultAspectRatioRaw = "circle"
        case .rectangle:
            defaultAspectRatioRaw = "rectangle"
        case .custom(let size):
            defaultAspectRatioRaw = "custom_\(size.width)_\(size.height)"
        }
    }
    
    private func loadDefaultAspectRatio() -> CropMethod {
        if defaultAspectRatioRaw.hasPrefix("custom_") {
            let components = defaultAspectRatioRaw.split(separator: "_")
            if components.count == 3,
               let width = Double(components[1]),
               let height = Double(components[2]) {
                return .custom(CGSize(width: width, height: height))
            }
        }
        
        switch defaultAspectRatioRaw {
        case "original":
            return .original
        case "freeform":
            return .freeform
        case "square":
            return .square
        case "ratio16_9":
            return .ratio16_9
        case "ratio4_5":
            return .ratio4_5
        case "ratio5_7":
            return .ratio5_7
        case "ratio4_3":
            return .ratio4_3
        case "ratio3_5":
            return .ratio3_5
        case "ratio3_2":
            return .ratio3_2
        case "rectangle":
            return .rectangle
        case "circle":
            return .circle
        default:
            return .square
        }
    }
}

@available(iOS 17.0, *)
struct SelectableImgUi_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }
    
    struct Container: View {
        @State var isShowingPicker: Bool = false
        @State var croppedImg: UIImage?
        
        var body: some View {
            NavigationStack {
                VStack {
                    EditImageView(croppedImg: $croppedImg)

                    HStack {
                        EditImageView(croppedImg: $croppedImg)
                        EditImageView(croppedImg: $croppedImg)
                    }
                }
            }
        }
    }
}
