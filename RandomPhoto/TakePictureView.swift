//
//  TakePictureView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-12.
//

import SwiftUI


struct TakePictureView: View {
    @StateObject private var model = ContentViewModel()
    var body: some View{
        Text("Atos Camera").bold()
        FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)
        Button("Photo"){
            CameraManager.shared.capture()
        }
    }
}

