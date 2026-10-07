#if canImport(UIKit) // iOS-only file: UIKit camera/crop/appearance/notification APIs
//
//  View+.swift
//  PhotoCrop
//
//  Created by Aaron Anthony on 2023-05-26.
//

import SwiftUI
import PhotosUI

/// Pan and zoom of an image inside a crop frame. `offset` is in points of the
/// frame, `scale` is on top of the aspect-fill fit (1 = just covers the frame).
public struct CropTransform: Equatable {
    public var scale: CGFloat
    public var offset: CGSize

    public init(scale: CGFloat = 1, offset: CGSize = .zero) {
        self.scale = scale
        self.offset = offset
    }

    /// Pulls the image back so it still covers the whole frame.
    func clamped(image: CGSize, frame: CGSize) -> CropTransform {
        let s = max(1, scale)
        let fill = image.width > 0 && image.height > 0
            ? max(frame.width / image.width, frame.height / image.height) : 1
        let maxX = max(0, (image.width * fill * s - frame.width) / 2)
        let maxY = max(0, (image.height * fill * s - frame.height) / 2)
        return CropTransform(scale: s, offset: CGSize(width: min(max(offset.width, -maxX), maxX),
                                                      height: min(max(offset.height, -maxY), maxY)))
    }
}

/// The crop frame with pan and pinch, and no navigation chrome — host it in
/// your own stack, and from your own Done call
/// `image.cropped(to: method, transform: transform)`.
@available(iOS 17.0, *)
public struct CropEditor: View {
    let image: UIImage
    let method: CropMethod
    @Binding var transform: CropTransform

    @State private var baseScale: CGFloat = 1
    @State private var baseOffset: CGSize = .zero

    public init(image: UIImage, method: CropMethod, transform: Binding<CropTransform>) {
        self.image = image
        self.method = method
        self._transform = transform
    }

    public var body: some View {
        let frame = method.size(for: image.size)
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: frame.width, height: frame.height)
            .scaleEffect(transform.scale)
            .offset(transform.offset)
            .clipShape(method == .circle ? AnyShape(Circle()) : AnyShape(Rectangle()))
            .overlay { CropGrid(circle: method == .circle) }
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        transform.offset = CGSize(width: baseOffset.width + value.translation.width,
                                                  height: baseOffset.height + value.translation.height)
                    }
                    .onEnded { _ in settle(frame: frame) }
                    .simultaneously(with: MagnifyGesture()
                        .onChanged { value in
                            transform.scale = max(1, baseScale * value.magnification)
                        }
                        .onEnded { _ in settle(frame: frame) })
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear { syncBase() }
            .onChange(of: method) {
                transform = CropTransform()
                syncBase()
            }
    }

    private func settle(frame: CGSize) {
        let clamped = transform.clamped(image: image.size, frame: frame)
        if clamped.offset != transform.offset {
            haptics(.medium)
        }
        withAnimation(.easeIn(duration: 0.2)) { transform = clamped }
        syncBase()
    }

    private func syncBase() {
        baseScale = transform.scale
        baseOffset = transform.offset
    }
}

/// Rule-of-thirds grid, or a dimmed surround for a circle.
private struct CropGrid: View {
    let circle: Bool

    var body: some View {
        if circle {
            ZStack {
                Rectangle()
                    .fill(.black.opacity(0.5))
                    .mask {
                        Rectangle()
                            .overlay {
                                Circle()
                                    .blendMode(.destinationOut)
                            }
                    }
                Circle()
                    .strokeBorder(.white, lineWidth: 2)
            }
            .allowsHitTesting(false)
        } else {
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
            .allowsHitTesting(false)
        }
    }
}

public extension UIImage {
    /// The part of the image inside the crop frame, cut from the original
    /// pixels — so the result keeps the photo's full resolution rather than
    /// the size it was shown at. A circle crop comes back with a transparent
    /// surround. nil if the image has no bitmap.
    func cropped(to method: CropMethod, transform: CropTransform) -> UIImage? {
        let upright = uprighted()
        guard let cg = upright.cgImage else { return nil }
        let pixels = CGSize(width: cg.width, height: cg.height)
        let frame = method.size(for: upright.size)
        let t = transform.clamped(image: upright.size, frame: frame)

        // Frame points per pixel once fitted and zoomed.
        let k = max(frame.width / pixels.width, frame.height / pixels.height) * t.scale
        let width = frame.width / k
        let height = frame.height / k
        let rect = CGRect(x: pixels.width / 2 - t.offset.width / k - width / 2,
                          y: pixels.height / 2 - t.offset.height / k - height / 2,
                          width: width, height: height)
            .integral
            .intersection(CGRect(origin: .zero, size: pixels))
        guard !rect.isEmpty, let cut = cg.cropping(to: rect) else { return nil }
        let result = UIImage(cgImage: cut, scale: 1, orientation: .up)
        return method == .circle ? result.circleMasked() : result
    }

    /// Redrawn with its orientation applied, so `cgImage` matches what's seen.
    private func uprighted() -> UIImage {
        guard imageOrientation != .up else { return self }
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

    private func circleMasked() -> UIImage {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = scale
        format.opaque = false
        let rect = CGRect(origin: .zero, size: size)
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            UIBezierPath(ovalIn: rect).addClip()
            draw(in: rect)
        }
    }
}

/// Full-screen crop with its own navigation bar, Cancel, aspect picker and
/// Done. To own the navigation and Done yourself, use `CropEditor`.
@available(iOS 17.0, *)
public struct CropView: View {

    var crop: CropMethod
    var img: UIImage?
    var onCrop: (UIImage?, Bool) -> ()
    var aspectRatios: [CropMethod]

    @Environment(\.dismiss) var dismiss
    @State private var transform = CropTransform()
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
            editor
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
                            if let image = img?.cropped(to: selectedCrop, transform: transform) {
                                onCrop(image, true)
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
                            }
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
        }
    }

    @ViewBuilder
    private var editor: some View {
        if let img {
            CropEditor(image: img, method: selectedCrop, transform: $transform)
        } else {
            ProgressView()
                .tint(.white)
        }
    }
}

@available(iOS 17.0, *)
struct CropView_Previews: PreviewProvider {
    static var previews: some View {
        CropView(crop: .square, img: UIImage(named: "testPhoto")) { _, _ in

        }
    }
}

#endif
