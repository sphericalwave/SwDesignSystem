//
//  EditProfileImageView.swift
//  SwShared
//
//  Created by Claude Code on 2026-04-05.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
public struct EditProfileImageView: View {
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var showCropView = false
    @Binding var profileImage: UIImage?
    
    public init(profileImage: Binding<UIImage?>) {
        self._profileImage = profileImage
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            // Profile image or placeholder
            ZStack {
                if let profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .strokeBorder(.white.opacity(0.3), lineWidth: 2)
                        }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.white.opacity(0.3))
                }
            }
            
            // PhotosPicker button
            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                HStack(spacing: 8) {
                    Image(systemName: profileImage == nil ? "photo.badge.plus" : "photo.badge.arrow.down")
                    Text(profileImage == nil ? "Add Photo" : "Change Photo")
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .onChange(of: selectedPhoto) {
                Task {
                    if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                        showCropView = true
                    }
                }
            }
            
            // Remove photo button (only show if there's a profile image)
            if profileImage != nil {
                Button(role: .destructive) {
                    profileImage = nil
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "trash")
                        Text("Remove Photo")
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.red.opacity(0.1))
                    .foregroundColor(.red)
                    .cornerRadius(10)
                }
            }
        }
        .fullScreenCover(isPresented: $showCropView) {
            if let selectedImage {
                CropView(
                    crop: .circle,
                    img: selectedImage,
                    aspectRatios: [.circle]
                ) { croppedImage, success in
                    if success, let croppedImage {
                        profileImage = croppedImage
                    }
                    showCropView = false
                }
            }
        }
    }
}

@available(iOS 17.0, *)
struct EditProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileImageView(profileImage: .constant(nil))
            .preferredColorScheme(.dark)
    }
}
