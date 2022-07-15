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
    @State var statusMessage : String?
    @State var statusCode : NSNumber? 
    
    @Binding var photo: AVCapturePhoto?
    
    init(_ _photo: Binding<AVCapturePhoto?>){
        self._photo = _photo
    }
    var body: some View{
        if status == .uploading {
            CustomSpinner()
            Text("Please wait while the image is being approved").onAppear{
                // Upload the photo
                print("uploading photo")
                
                uploadPhoto(photo: $photo.wrappedValue!)
            }
        }else {
            Image(status == .rejected ? "Rejected" : "Approved").resizable().frame(width: status == .rejected ? 58 : 60, height: status == .rejected ? 58 : 44.65).padding(.bottom,73.35)
            Text(statusMessage ?? (status == .rejected ? "Please retake the image" : "Thank you for your participation") ).bold().bold().padding(.bottom, 4).multilineTextAlignment(.center)
            Text((status == .rejected ? "Need help? Go back to the user guide":"Your image has been approved")).padding(.bottom, 23)
            Button(status == .rejected ? "Retry" : "Close", action: {
                self.rootPresentationMode.wrappedValue.dismiss()
            }).buttonStyle(ButtonStyleDefault())
            
        }
        
    }
    
    
    func uploadPhoto(photo: AVCapturePhoto){
        guard PhotoCaptureProcessor.isDepthDataSupported == (photo.depthData?.depthDataMap != nil) else {
            self.status = .rejected
            self.statusMessage = "Image does not contain depth data, try taking the photo from futher away"
            self.statusCode = 404
            return
        }
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
                
                let approved =  response?["approved"] as? NSNumber
                let statusCode =  response?["statusCode"] as? NSNumber
                var statusMessage =  response?["statusMessage"] as? String
                
                guard approved != nil else {
                    self.status = .rejected
                    return
                }
                if(approved == 1){
                    self.status = .approved
                    if statusMessage == nil{
                        statusMessage = "Your image has been approved"
                    }
                    self.statusMessage = statusMessage
                    self.statusCode = statusCode
                    
                    print("Successfull request!")
                }else {
                    self.status = .rejected
                    if statusMessage == nil {
                        statusMessage = "Uknown error occured."
                    }
                    self.statusMessage = statusMessage
                    self.statusCode = statusCode
                }
            }catch{
                print(error)
                self.statusCode = 408
                self.statusMessage = "The requests was timed out."
                self.status = .rejected
            }
        }
        
        
        task.resume()
    }

}

