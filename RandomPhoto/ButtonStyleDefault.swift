//
//  ButtonStyle.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-15.
//

import Foundation
import SwiftUI

struct ButtonStyleDefault: ButtonStyle {
    var color: Color = Color(hex: "EF414B")!
    
    public func makeBody(configuration: ButtonStyleDefault.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(.white)
            .frame(width: 134, height: 51)
            .background(RoundedRectangle(cornerRadius: 25).fill(color))
            .compositingGroup()
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
