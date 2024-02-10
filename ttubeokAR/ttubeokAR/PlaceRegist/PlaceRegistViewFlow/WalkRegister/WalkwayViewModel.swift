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
import Moya

class WalkwayViewModel: ObservableObject, ImageHandling, InputAddressProtocol {
    
    //MARK: - Property
    @Published var walwayModel = WalkwayModel()
    @Published var isImagePickerPresented = false
    @Published var currentPageIndex: Int = 0
    @Published var navigationToNextView = false
    @Published var images: [UIImage] = []
    
    //MARK: - saveTextInputs
    @Published var firstPlaceName: String = ""
    @Published var fourthWalkwayDescription: String = ""

    @Published var currentLocation: CLLocation?
    
    
    //MARK: - ImageFunction
    /// 앨범 또는 카메라에서 사진을 가져와 추가하는 로직
    /// - Parameter image: 앨범 또는 카메라로 추가한 이미지
    var selectedImageCount: Int {
        images.count
    }
    
    
    /// 앨범에서 선택한 이미지 추가하기
    /// - Parameter newImages: 추가한 이미지 배열에 넣기
    public func addImage(_ newImages: [UIImage]) {
        images.append(contentsOf: newImages)
    }
    
    /// 앨범 띄우기
    public func showImagePicker() {
        isImagePickerPresented = true
    }
    
    /// 배열에 추가한 이미지 삭제하기
    /// - Parameter index: 삭제할 이미지 인덱스 선택
    public func removeImage(at index: Int) {
        if images.indices.contains(index) {
            images.remove(at: index)
        }
    }
    
    /// 저장된 이미지 얻기
    /// - Returns: 이미지 리턴
    func getImages() -> [UIImage] {
        images
    }
    
    //MARK: - currentAddress Function
    
    
    @Published var address: String = ""
    @Published var detailAddress: String = ""
    
    
    /// 현재 버튼을 눌러 위치 활성화하기
    public func searchAddress() {
        BaseLocationManager.shared.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let currentLocation = BaseLocationManager.shared.getCurrentLocation() {
                ReverseGeocodingService().fetchReverseGeocodingData(latitude: currentLocation.coordinate.latitude,
                                                                    longitude: currentLocation.coordinate.longitude) { [weak self] address in
                    DispatchQueue.main.async {
                        self?.address = address ?? "주소를 찾을 수 없습니다."
                        BaseLocationManager.shared.stopUpdatingLocation()
                    }
                }
            }
        }
    }
}
