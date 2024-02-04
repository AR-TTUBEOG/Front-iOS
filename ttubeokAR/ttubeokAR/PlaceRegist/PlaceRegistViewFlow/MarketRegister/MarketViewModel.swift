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
    @Published var selectedImageCount: Int = 0
    
    //MARK: - saveTextInputs
    @Published var firstMarketName: String = ""
    @Published var secondAddressName: String = ""
    @Published var secondDetailAddress: String = ""
    @Published var thirdMarketTypeName: String = ""
    @Published var fifthMarketDescription: String = ""
    
    //MARK: - Function
    public func addImage(_ images: [UIImage]) {
        marketModel.images.append(contentsOf: images)
        selectedImageCount = marketModel.images.count
    }
    
    public func showImagePicker() {
        isImagePickerPresented = true
    }
    
    public func removeImage(at index: Int) {
        guard marketModel.images.indices.contains(index) else { return }
        marketModel.images.remove(at: index)
        selectedImageCount = marketModel.images.count
    }
}

