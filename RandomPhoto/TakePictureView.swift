//
//  TakePictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-12.
//

import SwiftUI


struct TakePictureView: View {
    let contentView : ContentView;
    @StateObject var model = TakePictureViewModel()
    @State var isShowingConfirmPhotoView = false
    
    init(_ _contentView: ContentView){
        contentView = _contentView
        print("Initialize take picture view")
    }
    
    var body: some View{
        
        NavigationLink(destination: ConfirmPictureView($model.takenPhoto.wrappedValue).navigationBarBackButtonHidden(true), isActive: $isShowingConfirmPhotoView ){
            EmptyView()
        }
        
        FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)
        Button("Photo"){
            // When we have taken a picutre, view the picture
            CameraManager.shared.capture()
            isShowingConfirmPhotoView = true
            
        }
    }
}

