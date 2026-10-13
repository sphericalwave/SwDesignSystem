#if canImport(UIKit) // iOS-only file: UIKit camera/crop/appearance/notification APIs
//
//  ContentView.swift
//  Camera
//
//  Created by Aaron Anthony on 2023-07-24.
//

import SwiftUI
import AVFoundation

@available(iOS 17.0, *)
public struct CameraView: View {

    @StateObject var camera: CameraModel
    /// Shows a 1:1 viewfinder so the frame matches the square crop that follows.
    var square: Bool

    public init(camera: CameraModel, square: Bool = false) {
        self._camera = StateObject(wrappedValue: camera)
        self.square = square
    }
    
    public var body: some View {
        ZStack {
            
            if square {
                Color.black.ignoresSafeArea()
                CameraPreview(camera: camera)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                CameraPreview(camera: camera)
                    .ignoresSafeArea(.all, edges: .all)
            }
            
            VStack {
                HStack {
                    Button(action: { camera.isShowingCamera.wrappedValue = false }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 10)

                    Spacer()
                }
                Spacer()
                HStack {
                    Color.clear.frame(width: 60, height: 60)
                    Spacer()
                    Button(action: camera.takePic) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 65, height: 65)
                            
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 75, height: 75)
                        }
                    }
                    Spacer()
                    Button(action: camera.flip) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.white.opacity(0.2)))
                    }
                    .accessibilityLabel("Flip Camera")
                }
                .padding(.horizontal, 30)
            }
        }
        .onAppear{
            camera.check()
        }
        .fullScreenCover(isPresented: $camera.showCropView,
                         onDismiss: {
                                        camera.photo = nil
                                        camera.isShowingCamera.wrappedValue = false
        } ) {
            CropView(crop: .square, img: camera.photo) { croppedImg, status in
                if let croppedImg {
                    camera.croppedImg.wrappedValue = croppedImg
                    camera.isShowingCamera.wrappedValue = false
                }
            }
        }
    }
}

public class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {

    @Published public var isTaken = false
    @Published public var session = AVCaptureSession()
    @Published public var alert = false
    @Published public var output = AVCapturePhotoOutput()
    @Published public var preview: AVCaptureVideoPreviewLayer!
    @Published public var isSaved = false
    @Published public var picData = Data(count: 0)
    @Published public var croppedImg: Binding<UIImage?>
    @Published public var photo: UIImage?
    public var isShowingCamera: Binding<Bool>
    @Published public var showCropView = false
    @Published public var position: AVCaptureDevice.Position

    public init(img: Binding<UIImage?>, isShowingCamera: Binding<Bool>, position: AVCaptureDevice.Position = .back) {
        self.croppedImg = img
        self.isShowingCamera = isShowingCamera
        self.position = position
    }

    /// Dual camera where there is one (the back), otherwise the plain wide angle
    /// — front cameras have no dual module.
    private static func device(for position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        AVCaptureDevice.default(.builtInDualCamera, for: .video, position: position)
            ?? AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position)
    }
    
    public func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
        default: return
        }
    }
    
    public func setUp(){
        do {
            session.beginConfiguration()
            defer { session.commitConfiguration() }
            guard let device = Self.device(for: position) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    public func flip() {
        let newPosition: AVCaptureDevice.Position = position == .front ? .back : .front
        guard let device = Self.device(for: newPosition),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        session.beginConfiguration()
        session.inputs.forEach { session.removeInput($0) }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        session.commitConfiguration()
        position = newPosition
    }
    
    public func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            //self.session.stopRunning() causing delegate to not be called
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }
    
    public func retakePic() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
                self.isSaved = false
            }
        }
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        print("pic taken")
        
        guard let imgData = photo.fileDataRepresentation() else {
            return
        }
        self.picData = imgData
        if let i = UIImage(data: self.picData) {
            self.photo = i
        }
        self.showCropView = true
        
    }
    
    public func savePic() {
        //let img = UIImage(data: self.picData)!
        if let i = UIImage(data: self.picData) {
            croppedImg.wrappedValue = i
        }
        isSaved = true
        
        isShowingCamera.wrappedValue = false
        //self.session.stopRunning() //TODO: might need this
    }
}

public struct CameraPreview: UIViewRepresentable {

    @ObservedObject var camera: CameraModel

    public init(camera: CameraModel) {
        self.camera = camera
    }
    
    /// Backed by the preview layer itself so it tracks whatever frame SwiftUI
    /// gives it (full screen or the square viewfinder).
    public final class PreviewView: UIView {
        public override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
        var previewLayer: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }
    }

    public func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.previewLayer.session = camera.session
        view.previewLayer.videoGravity = .resizeAspectFill
        camera.preview = view.previewLayer
        camera.session.startRunning()
        return view
    }
    
    public func updateUIView(_ uiView: PreviewView, context: Context) {
        //
    }
}

#endif
