//
//  TakePictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-12.
//

import SwiftUI
import AVFoundation

struct TakePictureView: View {
    
    
    @State private var isActive = false
    
    @StateObject var viewModel = TakePictureViewModel()
    
    @State var isShowingConfirmPhotoView = false
    
    var image: AVCapturePhoto?
    
    init(){
        print("Initialize take picture view")
        
    }
    
    
    
    var body: some View{
        NavigationView{
            VStack{
                
                VideoView(parentViewModel: viewModel)
                    .padding(.top, 10)
                
                Button("Photo"){
                    // When we have taken a picutre, view the picture
                    CameraManager.shared.capture()
                    isActive = true
                    
                }
                .onAppear {
                    CameraManager.shared.startRunning()
                }
                .onDisappear {
                    CameraManager.shared.stopRunning()
                }
                NavigationLink(destination: ConfirmPictureView(photo: $viewModel.image).navigationBarBackButtonHidden(true), isActive: $isActive ){
                    EmptyView()
                }.isDetailLink(false)
            }
                
                /*
                NavigationLink(destination: ConfirmPictureView(takenPicture), tag: "confirmPicture", selection: $selection) {
                        EmptyView()
                }*/
            
        }.navigationViewStyle(StackNavigationViewStyle()).environment(\.rootPresentationMode, self.$isActive)
        /*NavigationLink(destination: ConfirmPictureView($model.takenPhoto).navigationBarBackButtonHidden(true), isActive: $isShowingConfirmPhotoView ){
            EmptyView()
        }*/
        
        
    }
}

