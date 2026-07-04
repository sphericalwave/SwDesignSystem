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

    public init(camera: CameraModel) {
        self._camera = StateObject(wrappedValue: camera)
    }
    
    public var body: some View {
        ZStack {
            
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
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

    public init(img: Binding<UIImage?>, isShowingCamera: Binding<Bool>) {
        self.croppedImg = img
        self.isShowingCamera = isShowingCamera
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
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            session.commitConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
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
    
    public func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
