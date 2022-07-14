//
//  ContentView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-11.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    @StateObject private var model = ContentViewModel()
    @State var selection: String? = "takePicture"
    @State var takenPicture: AVCapturePhoto?
    
    var body: some View {
        if model.isGuideDone == false {
            GuideView(model: model)
        }else {
        NavigationView{
            VStack{
                NavigationLink(destination: TakePictureView(self).navigationBarBackButtonHidden(true), tag: "takePicture", selection: $selection ){
                    EmptyView()
                }
                /*
                NavigationLink(destination: ConfirmPictureView(takenPicture), tag: "confirmPicture", selection: $selection) {
                        EmptyView()
                }*/
            }
            
        }
        }
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
