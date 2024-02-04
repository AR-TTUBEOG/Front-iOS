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
    @Published var selectedImageCount: Int = 0
    @Published var navigationToNextView = false
    
    //MARK: - saveTextInputs
    @Published var firstPlaceName: String = ""
    @Published var secondAddressName: String = ""
    @Published var secondDetailAddress: String = ""
    @Published var fourthWalkwayDescription: String = ""
    //MARK: - Function
    /// 앨범 또는 카메라에서 사진을 가져와 추가하는 로직
    /// - Parameter image: 앨범 또는 카메라로 추가한 이미지
    public func addImage(_ images: [UIImage]) {
        walwayModel.images.append(contentsOf: images)
        selectedImageCount = walwayModel.images.count
    }
    
    //TODO: - 앨범 또는 카메라에서 사진 촬영 하는 로직 필요
    /// 이미지 피커 사용을 위한 값
    public func showImagePicker() {
        isImagePickerPresented = true
        
    }
    
    public func removeImage(at index: Int) {
        guard walwayModel.images.indices.contains(index) else { return }
        walwayModel.images.remove(at: index)
        selectedImageCount = walwayModel.images.count
    }
    
}
