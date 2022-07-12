//
//  CameraManager.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-11.
//
import AVFoundation


class CameraManager: NSObject {
    
    @Published var error: CameraError?
    
    public let session = AVCaptureSession()
    
    private let sessionQueue = DispatchQueue(label: "com.raywenderlich.SessionQ")
    
    public let videoOutput = AVCaptureVideoDataOutput()
    
    private var status = Status.unconfigured
    
    public var photoOutput = AVCapturePhotoOutput()
  
    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
    }
    
    static let shared = CameraManager()
  
    override init() {
        super.init()
        configure()
    }
  
    private func configure() {
        checkPermissions()
        sessionQueue.async {
          self.configureCaptureSession()
          self.session.startRunning()
        }

    }
    private func set(error: CameraError?) {
      DispatchQueue.main.async {
        self.error = error
      }
    }
    private func checkPermissions() {
      // 1
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .notDetermined:
        // 2
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { authorized in
          // 3
          if !authorized {
            self.status = .unauthorized
            self.set(error: .deniedAuthorization)
          }
          self.sessionQueue.resume()
        }
      // 4
      case .restricted:
        status = .unauthorized
        set(error: .restrictedAuthorization)
      case .denied:
        status = .unauthorized
        set(error: .deniedAuthorization)
      // 5
      case .authorized:
        break
      // 6
      @unknown default:
        status = .unauthorized
        set(error: .unknownAuthorization)
      }

    }
    private func configureCaptureSession() {
          guard status == .unconfigured else {
            return
          }
          session.beginConfiguration()
          defer {
            session.commitConfiguration()
          }
        let device = AVCaptureDevice.default(
          .builtInDualWideCamera,
          for: .video,
          position: .unspecified)
        
        // Capture depth data
        guard let camera = device else {
          set(error: .cameraUnavailable)
          status = .failed
          return
        }
        // Set up photo output for depth data capture.
        guard session.canAddOutput(photoOutput)
            else { fatalError("Can't add photo output.") }
        
        
        do {
          // 1
            let cameraInput = try AVCaptureDeviceInput(device: camera)
          // 2
          if session.canAddInput(cameraInput) {
            session.addInput(cameraInput)
          } else {
            // 3
            set(error: .cannotAddInput)
            status = .failed
            return
          }
        } catch {
          // 4
          set(error: .createCaptureInput(error))
          status = .failed
          return
        }
        // 1
        if session.canAddOutput(videoOutput)  && session.canAddOutput(photoOutput){
            photoOutput = AVCapturePhotoOutput()
            session.addOutput(videoOutput)
            session.addOutput(photoOutput)
            // 2
            videoOutput.videoSettings =
                [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            
            
            session.sessionPreset = .photo
            
            photoOutput.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported

          // 3
          let videoConnection = videoOutput.connection(with: .video)
            
            videoConnection?.videoOrientation = .portrait
            videoConnection?.isVideoMirrored = true
        } else {
          // 4
          set(error: .cannotAddOutput)
          status = .failed
          return
        }
    }
    func set(
      _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
      queue: DispatchQueue
    ) {
      sessionQueue.async {
        self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
      }
    }
    
    func takePhoto(){
        
        // Take the photo
        let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        
        photoSettings.isDepthDataDeliveryEnabled = photoOutput.isDepthDataDeliverySupported
        print(photoSettings.isDepthDataDeliveryEnabled)
        
        print("Taking photo")
        
        photoOutput.capturePhoto(with: photoSettings, delegate: PhotoCaptureProcessor())
        print("We are past capturePhoto")
    }

}


class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate{
    
    public func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        print("This doesn't run :(")
        
    }
    
}
