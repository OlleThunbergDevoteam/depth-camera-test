//
//  ConfirmPictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-13.
//


import AVFoundation
import SwiftUI

struct ConfirmPictureView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var photo : AVCapturePhoto?
    @State var isShowingUploadPictureView = false
    
    private let label = Text("Preview Image")
    
    var body: some View{
        
        NavigationLink(destination: UploadPictureView(_photo).navigationBarBackButtonHidden(true), isActive: $isShowingUploadPictureView ){
            EmptyView()
        }
        if($photo.wrappedValue != nil){
                Image($photo.wrappedValue!.cgImageRepresentation()!, scale: 0.5, orientation: .leftMirrored,label: label)
                  .resizable()
                  .padding(20).scaledToFit()
                Text("Are you happy with your image?")
            Button("Confirm", action: {
                // Navigate to to the uploadPictureView
                isShowingUploadPictureView = true
            })
            Button("Take another", action: {
                self.presentationMode.wrappedValue.dismiss()
            })
        }else {
            ProgressView().progressViewStyle(CircularProgressViewStyle())
        }
    }
    init(photo: Binding<AVCapturePhoto?>){
        self._photo = photo
        print("INit uploadpictureview")
    }
    
}
