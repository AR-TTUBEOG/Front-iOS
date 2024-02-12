//
//  MarketViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import Foundation
import SwiftUI
import Moya
import UIKit


class MarketViewModel: ObservableObject, ImageHandling, InputAddressProtocol, FinishViewProtocol {
    
    
    
    func searchAddress() {
        print("hello")
    }
    
    func finishPlaceRegist() {
        print("hello")
    }
    

    
    //MARK: - Property
    @Published var marketModel = MarketModel()
    @Published var currentPageIndex: Int = 0
    @Published var isImagePickerPresented = false
    @Published var navigationToNextView = false
    @Published var images: [UIImage] = []
    
    
    //MARK: - saveTextInputs
    @Published var firstMarketName: String = ""
    @Published var secondAddressName: String = ""
    @Published var secondDetailAddress: String = ""
    @Published var thirdMarketTypeName: String = ""
    @Published var fifthMarketDescription: String = ""
    
    var titleText: String = "매장 등록이 \n완료되었습니다."
    
    var highlightText: String = "매장"
    
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
    
    
    //MARK: - CurrentAddress
    
    
    @Published var address: String = ""
    
    @Published var detailAddress: String = ""
    
}

