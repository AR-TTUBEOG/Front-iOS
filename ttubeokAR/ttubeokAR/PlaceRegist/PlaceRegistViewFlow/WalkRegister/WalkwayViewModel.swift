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
    @Published var address: String = ""
    @Published var detailAddress: String = ""
    
    
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
    
    func getImages() -> [UIImage] {
        images
    }
    
    //MARK: - currentAddress Function
    
    
    @Published var currentLocation: CLLocation?
    @Published var errorMessage: String?
    let provider = MoyaProvider<NaverReverseGeocodingAPI>()
    
    private var locationManger = LocationManagerA.shared
    
    
    init() {
        LocationManagerA.shared.requestLocationAuthorization()
        
    }
    
    public func searchAddress() {
        LocationManagerA.shared.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 위치 정보를 받기 위해 약간의 지연을 줍니다.
            self.currentLocation = LocationManagerA.shared.currentLocation
            LocationManagerA.shared.stopUpdatingLocation()
            self.fetchReverseGeocodingData()
        }
    }
    
    //        private func fetchCurrentLocation() {
    //            locationManger.getLocation { [weak self] location, error in
    //                DispatchQueue.main.async {
    //                    if let location = location {
    //                        print("주소 값 전환 성공")
    //                        self?.currentLocation = location
    //                        self?.fetchReverseGeocodingData()
    //                    } else if let error = error {
    //                        self?.errorMessage = error.localizedDescription
    //                    }
    //                }
    //            }
    //        }
    //
    private func fetchReverseGeocodingData() {
        if let lat = currentLocation?.coordinate.latitude, let lng = currentLocation?.coordinate.longitude {
            let formattedLat = String(format: "%.8f", lat)
            let formattedLng = String(format: "%.8f", lng)
            provider.request(.reverseGeocode(latitude: formattedLat, logitude: formattedLng)) { [weak self] result in
                switch result {
                case .success(let response):
                    do {
                        print("데이터 포스트 성공")
                        let decodedData = try JSONDecoder().decode(ReverseGeoCodingData.self, from: response.data)
                        if let firstResult = decodedData.results.first {
                            self?.makeroadAddress(from: firstResult)
                            print("해독 성공")
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print("네트워크 에러: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func makeroadAddress(from result: ResultData) {
        let area1 = result.region.area1.name
        let area2 = result.region.area2.name
        let area3 = result.region.area3.name
        let area4 = result.region.area4.name
        
        
        let baseAddress = [area1, area2, area3, area4].joined(separator: " ")
        
        DispatchQueue.main.async { [weak self] in
            self?.address = baseAddress
        }
    }
}
