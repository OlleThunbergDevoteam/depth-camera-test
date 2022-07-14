import CoreImage
import AVFoundation
import Foundation
import Combine

class VideoViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate  {
    // 1
    @Published var frame: CGImage?
    // 2
    private let frameManager = FrameManager.shared
    
    @Published var takenPhoto: AVCapturePhoto?
    
    let parentViewModel: TakePictureViewModel
    
    private var frameManagerCancellable: AnyCancellable?
    
    init(parentViewModel: TakePictureViewModel) {
        self.parentViewModel = parentViewModel
        super.init()
        print("Initialized takePictureViewModel")
        setupSubscriptions()
        // Setup the delegate for the CameraManaager
        CameraManager.shared.cameraDelegate = self
        if CameraManager.deviceType == nil {
            CameraManager.setupDeviceType()
        }
    }
    
    // 3
    func setupSubscriptions() {
        // 1
        frameManagerCancellable = frameManager.$current
        // 2
            .receive(on: RunLoop.main)
        // 3
            .compactMap { buffer in
                return CGImage.create(from: buffer)
            }
        // 4
            .assign(to: \.frame, on: self)
        
    }
    func cancel() { frameManagerCancellable = nil }
}
extension VideoViewModel{
    
    public func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {
            return
        }
        print("PhotoDelegate ran")
        takenPhoto = photo
        parentViewModel.image = photo
    }
    
}
