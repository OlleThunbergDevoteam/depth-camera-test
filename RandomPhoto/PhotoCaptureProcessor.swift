import AVFoundation
import Foundation

class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate{
    
    public static var deviceType: String?
    public var takenPhoto: AVCapturePhoto?
    override init(){
        if PhotoCaptureProcessor.deviceType == nil {
            PhotoCaptureProcessor.setupDeviceType()
        }
    }
    static func setupDeviceType(){
        // Update the device type on the photoCaptureProcessor class
        PhotoCaptureProcessor.deviceType = {
            var utsnameInstance = utsname()
            uname(&utsnameInstance)
            let optionalString: String? = withUnsafePointer(to: &utsnameInstance.machine) {
                $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                    ptr in String.init(validatingUTF8: ptr)
                }
            }
            return optionalString ?? "N/A"
    }()
        
        
    }
    public func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard error == nil else {
            return
        }
        takenPhoto = photo
    }
    
}
