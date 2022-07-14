//
//  GuideView.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-12.
//

import SwiftUI

struct GuideView: View {
    private var viewModel : ContentViewModel?
    init(model: ContentViewModel){
        print("Initialize guideview")
        viewModel = model
    }
    var body: some View{
        Text("Hello world")
        Button(action: {
            viewModel?.isGuideDone = true
        }, label: {
            Text("Done")
        })
    }
}
