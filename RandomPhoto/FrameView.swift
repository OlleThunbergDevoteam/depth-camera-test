//
//  FrameView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-11.
//

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("Camera feed")

    var body: some View {
        // 1
        if let image = image {
                
            Image(image, scale: 0.5, orientation: .upMirrored, label: label)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 334, height: 547, alignment: .center)
                  .cornerRadius(20).overlay(
                    Image("CameraOverlay").resizable().scaledToFit().padding(.horizontal, 19).padding(.vertical, 21)
                  )
        } else {
          // 4
          Color.black
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
