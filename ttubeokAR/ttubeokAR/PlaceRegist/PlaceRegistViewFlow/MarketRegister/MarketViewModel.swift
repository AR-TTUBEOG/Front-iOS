//
//  MarketViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import Foundation
import SwiftUI

class MarketViewModel: ObservableObject, ImageHandling {
    
    
    
    
    
    //MARK: - Property
    @Published var marketModel = MarketModel()
    @Published var currentPageIndext: Int = 5
    @Published var isImagePickerPresented = false
    @Published var images: [UIImage] = []
    
    
    //MARK: - saveTextInputs
    @Published var firstMarketName: String = ""
    @Published var secondAddressName: String = ""
    @Published var secondDetailAddress: String = ""
    @Published var thirdMarketTypeName: String = ""
    @Published var fifthMarketDescription: String = ""
    
    //MARK: - Protocol
    
    var selectedImageCount: Int {
        images.count
    }
    
    
    public func addImage(_ newImages: [UIImage]) {
        images.append(contentsOf: newImages)
    }
    
    public func showImagePicker() {
        isImagePickerPresented = true
    }
    
    public func removeImage(at index: Int) {
        if images.indices.contains(index) {
            images.remove(at: index)
        }
    }
    
    func getImages() -> [UIImage] {
        images
    }
    
    func imageToBase64String(img: UIImage) -> String? {
        return "test"
    }
    
}

