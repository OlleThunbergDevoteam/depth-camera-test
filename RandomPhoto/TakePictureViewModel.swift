//
//  TakePictureViewModel.swift
//  RandomPhoto
//
//  Created by admin on 2022-07-14.
//

import Foundation
import AVFoundation
class TakePictureViewModel: ObservableObject {
    @Published var isActive = false
    var image: AVCapturePhoto? {
        didSet { isActive = image != nil }
    }
}
