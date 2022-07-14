//
//  ConfirmPictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-13.
//


import AVFoundation
import SwiftUI

struct ConfirmPictureView: View {
    @State var previewImage : UIImage
    private var photo : AVCapturePhoto?
    
    
    var body: some View{
        Text("Confirm picture")
        
            Image(uiImage: previewImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
        
        
    }
    init(_ _photo: AVCapturePhoto?){
        print("Initialize run")
        print("IsrawPhoto",photo?.isRawPhoto)
        guard _photo != nil else {
            previewImage = UIImage()
            return
        }
        photo = _photo
        let CGImage = photo!.cgImageRepresentation()
        
        let CIImage = CIImage(cgImage: CGImage!)
        
        previewImage = UIImage(ciImage: CIImage)
        // Render the photo to the page.
    }
    func uploadPhoto(photo: AVCapturePhoto){
        /*guard let url = URL(string: "http:192.168.86.19:3000/upload/photo")else{
            return
        }*/
        guard let url = URL(string: "https://zypode80n4.execute-api.us-east-1.amazonaws.com/dev/upload")else{
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String: AnyHashable] = [
            "imageType": "3D",
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
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Success \(response)")
            }catch{
                print(error)
            }
        }
        
        
        task.resume()
    }
}
