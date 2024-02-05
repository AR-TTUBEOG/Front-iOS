//
//  WalkwayViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import Foundation
import SwiftUI
import UIKit
import PhotosUI

class WalkwayViewModel: ObservableObject, ImageHandling {
    
    
    
    //MARK: - Property
    @Published var walwayModel = WalkwayModel()
    @Published var isImagePickerPresented = false
    @Published var currentPageIndex: Int = 0
    @Published var navigationToNextView = false
    @Published var images: [UIImage] = []
    
    //MARK: - saveTextInputs
    @Published var firstPlaceName: String = ""
    @Published var secondAddressName: String = ""
    @Published var secondDetailAddress: String = ""
    @Published var fourthWalkwayDescription: String = ""
    //MARK: - Function
    /// 앨범 또는 카메라에서 사진을 가져와 추가하는 로직
    /// - Parameter image: 앨범 또는 카메라로 추가한 이미지
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
    
    
}
