//
//  UploadPictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-14.
//

import Foundation
import AVFoundation
import SwiftUI
import AVFoundation

enum Status{
    case uploading, approved, rejected
    
}
struct UploadPictureView: View {
    @Environment(\.rootPresentationMode) private var rootPresentationMode
    
    @State var status : Status = .uploading
    @Binding var photo: AVCapturePhoto?
    
    init(_ _photo: Binding<AVCapturePhoto?>){
        self._photo = _photo
    }
    var body: some View{
        
        if status == .uploading {
            Text("Please wait while the image is being approved").onAppear{
                // Upload the photo
                print("uploading photo")
                
                uploadPhoto(photo: $photo.wrappedValue!)
            }
        }else if status == .approved {
            Text("Your image has been approved")
            Button("Close", action: {
                self.rootPresentationMode.wrappedValue.dismiss()
            })
        }else if status == .rejected {
            Text("Please retake the image.")
            Button("Retry", action: {
                self.rootPresentationMode.wrappedValue.dismiss()
            })
            
        }
        
    }
    
    
    func uploadPhoto(photo: AVCapturePhoto){
        guard let url = URL(string: "http:192.168.86.19:3000/upload/photo")else{
            return
        }
        /*
        guard let url = URL(string: "https://zypode80n4.execute-api.us-east-1.amazonaws.com/dev/upload")else{
            return
        }*/
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String: AnyHashable] = [
            "imageType": photo.depthData?.depthDataMap != nil ? "3D" : "2D",
            "supportsDepthData": PhotoCaptureProcessor.isDepthDataSupported,
            "userdata": [
                "location" : "SWE",
                "device" : PhotoCaptureProcessor.deviceType
            ],
            "image": "data:image/jpg;base64," + photo.fileDataRepresentation()!.base64EncodedString()
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request){ data, _, _ in
            guard let data = data else {
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                let success =  response?["success"] as? NSNumber
                guard success != nil else {
                    self.status = .rejected
                    return
                }
                if(success == 1){
                    self.status = .approved
                    print("Successfull request!")
                }else {
                    self.status = .rejected
                }
            }catch{
                print(error)
            }
        }
        
        
        task.resume()
    }

}

