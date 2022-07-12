//
//  ContentView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-11.
//

import SwiftUI

enum Route {
    case guide
    case camera
}
struct Navigator{
    static func navigate<T: View>(_ route: Route, content: () -> T) -> AnyView{
        switch route{
        case .guide:
            return AnyView(NavigationLink(destination: GuideView()){
                content()
            })
        case .camera:
            return AnyView(NavigationLink(destination: TakePictureView()){
                content()
            })
        }
        
    }
}
struct ContentView: View {
    
    
    var body: some View {
        NavigationView{
            Button(action: {}, label: {
                Navigator.navigate(.camera){
                    Text("Go to camera")
                }
            })
        }
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
