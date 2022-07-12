//
//  ContentView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-11.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()

    var body: some View {
        Text("Atos Camera").bold()
        FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)
        Button("Photo"){
            CameraManager.shared.takePhoto()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
