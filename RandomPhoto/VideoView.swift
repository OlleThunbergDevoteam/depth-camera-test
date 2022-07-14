//
//  VideoView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-14.
//

import SwiftUI

struct VideoView: View {
    @ObservedObject var model: VideoViewModel
    //@State var parentViewModel: TakePictureView.TakePictureViewModel
    
    var body: some View {
        FrameView(image: model.frame)
            .edgesIgnoringSafeArea(.all)
    }
    
    init(parentViewModel: TakePictureViewModel) {
        model = VideoViewModel(parentViewModel: parentViewModel)
        print("Initialize videoview")
    }
}

/*struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}*/
