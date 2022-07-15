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
    @Environment(\.colorScheme) var colorScheme
    @State var takenPicture: AVCapturePhoto?

    var body: some View {
        
        ZStack {
            if(colorScheme == .light){
                Color("backgroundColor").ignoresSafeArea()
            }
            

            if model.isGuideDone == false {
                GuideView(model: model)
            }else {
                TakePictureView(model)
            }
            
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
