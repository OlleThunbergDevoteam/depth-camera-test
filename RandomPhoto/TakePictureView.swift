//
//  TakePictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-12.
//

import SwiftUI


struct TakePictureView: View {
    
    @State private var isActive = false
    @StateObject var model = TakePictureViewModel()
    @State var isShowingConfirmPhotoView = false
    
    init(){
        print("Initialize take picture view")
    }
    
    var body: some View{
        NavigationView{
            VStack{
                FrameView(image: model.frame)
                    .edgesIgnoringSafeArea(.all)
                
                Button("Photo"){
                    // When we have taken a picutre, view the picture
                    CameraManager.shared.capture()
                    isActive = true
                    
                }
                NavigationLink(destination: ConfirmPictureView($model.takenPhoto).navigationBarBackButtonHidden(true), isActive: $isActive ){
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

