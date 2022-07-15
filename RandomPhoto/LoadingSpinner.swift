//
//  LoadingSpinner.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-15.
//

import Foundation
import SwiftUI

struct CustomSpinner: View {
    var frameSize: CGFloat = 72
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2)
            
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
            Image("LoadingSpinner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: frameSize)
                .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0.0))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                              withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                                                  isAnimating = true
                                              }
                                          }
                    
                }
            
        
    }
}
