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
    
    var parrentViewModel : ContentViewModel
    
    var image: AVCapturePhoto?
    
    init(_ parrentViewModel: ContentViewModel){
        self.parrentViewModel = parrentViewModel
    }
    var body: some View{
        NavigationView{
            VStack{
                VideoView(parentViewModel: viewModel)
                Spacer()
                Button{
                    // When we have taken a picutre, view the picture
                    CameraManager.shared.capture()
                    isActive = true
                    
                } label: {
                    Image("RecordButton").resizable().frame(width: 58, height: 58)
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
        }.environment(\.rootPresentationMode, self.$isActive).navigationBarHidden(true).overlay(
            Button{
                parrentViewModel.isGuideDone = false
            } label: {
                Image("BackButton").resizable().frame(width: 35, height: 35).padding(22)
            }, alignment: .topLeading)
        /*NavigationLink(destination: ConfirmPictureView($model.takenPhoto).navigationBarBackButtonHidden(true), isActive: $isShowingConfirmPhotoView ){
            EmptyView()
        }*/
    }
}

