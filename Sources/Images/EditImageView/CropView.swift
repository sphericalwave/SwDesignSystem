//
//  View+.swift
//  PhotoCrop
//
//  Created by Aaron Anthony on 2023-05-26.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
public struct CropView: View {

    var crop: CropMethod
    var img: UIImage?
    var onCrop: (UIImage?, Bool) -> ()
    var aspectRatios: [CropMethod]
    
    @Environment(\.dismiss) var dismiss
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    @GestureState var isInteracting: Bool = false
    @State private var selectedCrop: CropMethod
    @State private var showAspectRatioPicker: Bool = false

    public init(crop: CropMethod, img: UIImage?, aspectRatios: [CropMethod] = [.square, .rectangle, .circle], onCrop: @escaping (UIImage?, Bool) -> ()) {
        self.crop = crop
        self.img = img
        self.aspectRatios = aspectRatios
        self.onCrop = onCrop
        self._selectedCrop = State(initialValue: crop)
    }
    
    public var body: some View {
        NavigationStack {
            img()
                .navigationTitle("Crop View")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.black.opacity(0.95), for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(.visible, for: .bottomBar)
                .toolbarBackground(Color.black.opacity(0.95), for: .bottomBar)
                .toolbarColorScheme(.dark, for: .bottomBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.85).ignoresSafeArea())
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Text("Cancel")
                                .fontWeight(.regular)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            showAspectRatioPicker = true
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "aspectratio")
                                Text(selectedCrop.name())
                                    .font(.subheadline)
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.caption2)
                            }
                        }
                        .tint(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            //convert view to image
                            let renderer = ImageRenderer(content: img(hideGrids: true))
                            renderer.proposedSize = .init(selectedCrop.size())
                            if let image = renderer.uiImage {
                                // Apply circular mask if circle crop is selected
                                let croppedImage = selectedCrop == .circle ? applyCircularMask(to: image) : image
                                onCrop(croppedImage, true)
                            }
                            else {
                                onCrop(nil, false)
                            }
                            dismiss()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark")
                                Text("Done")
                                    .fontWeight(.semibold)
                            }
                        }
                        .tint(.white)
                    }
                }
                .confirmationDialog("Select Aspect Ratio", isPresented: $showAspectRatioPicker, titleVisibility: .visible) {
                    ForEach(Array(aspectRatios.enumerated()), id: \.offset) { index, aspectRatio in
                        Button(aspectRatio.name()) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedCrop = aspectRatio
                                resetTransform()
                            }
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
        }
    }
    
    private func resetTransform() {
        scale = 1
        lastScale = 0
        offset = .zero
        lastStoredOffset = .zero
    }
    
    @ViewBuilder
    func img(hideGrids: Bool = false) -> some View {
        let cropSize = selectedCrop.size()
        GeometryReader {
            let size = $0.size
            if let img {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(content: {
                        GeometryReader { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            Color.clear
                                .onChange(of: isInteracting) {
                                    //true dragging
                                    //false stopped dragging
                                    //w geometryReader we can now read minX, Y etc of image
                                    
                                    withAnimation(.easeIn(duration: 0.2)) {
                                        if rect.minX > 0 {
                                            //resetting to last location
                                            offset.width = (offset.width - rect.minX)
                                            haptics(.medium)
                                        }
                                        if rect.minY > 0 {
                                            //resetting to last location
                                            offset.height = (offset.height - rect.minY)
                                            haptics(.medium)
                                        }
                                        
                                        if rect.maxX < size.width {
                                            //resetting to last location
                                            offset.width = (rect.minX - offset.width)
                                            haptics(.medium)
                                        }
                                        if rect.maxY < size.height {
                                            //resetting to last location
                                            offset.height = (rect.minY - offset.height)
                                            haptics(.medium)
                                        }
                                    }
                                    
                                    if !isInteracting {
                                        lastStoredOffset = offset
                                    }
                                    
                                }
                        }
                    })
                    .frame(size)
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        .clipShape(selectedCrop == .circle ? AnyShape(Circle()) : AnyShape(Rectangle()))
        .overlay(content: {
            if !hideGrids {
                grids()
            }
        }
        )
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
            DragGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                })
                .onChanged { value in
                    let translation = value.translation
                    offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
                }
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting, body: { _ , out, _ in
                    out = true
                })
                .onChanged { value in
                    let updatedScale = value + lastScale
                    scale = (updatedScale < 1 ? 1: updatedScale)
                }
                .onEnded { value in
                    withAnimation(.easeIn(duration: 0.2)) {
                        if scale < 1 {
                            scale = 1
                            lastScale = 0
                        }
                        else {
                            lastScale = scale - 1
                        }
                    }
                }
        )
        .frame(cropSize)
    }
    
    @ViewBuilder
    func grids() -> some View {
        if selectedCrop == .circle {
            // Circular crop overlay with dimmed outside area
            GeometryReader { geometry in
                ZStack {
                    // Dimmed overlay for the area outside the circle
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .mask {
                            Rectangle()
                                .overlay {
                                    Circle()
                                        .blendMode(.destinationOut)
                                }
                        }
                    
                    // White circle border
                    Circle()
                        .strokeBorder(.white, lineWidth: 2)
                }
            }
        } else {
            // Standard rectangular grid
            ZStack {
                HStack {
                    ForEach(1...2, id: \.self) { _ in
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(width: 1)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                VStack {
                    ForEach(1...2, id: \.self) { _ in
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .frame(maxHeight: .infinity)
                    }
                }
            }
        }
    }
    
    private func applyCircularMask(to image: UIImage) -> UIImage {
        let size = image.size
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return image }
        
        // Create circular path
        let circlePath = UIBezierPath(ovalIn: rect)
        context.addPath(circlePath.cgPath)
        context.clip()
        
        // Draw the image
        image.draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? image
    }
}

@available(iOS 17.0, *)
struct CropView_Previews: PreviewProvider {
    static var previews: some View {
        CropView(crop: .square, img: UIImage(named: "testPhoto")) { _, _ in
            
        }
    }
}
