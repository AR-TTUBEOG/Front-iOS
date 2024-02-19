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
import CoreLocation

class WalkwayViewModel: ObservableObject, ImageHandling, InputAddressProtocol, FinishViewProtocol {
    
    
    //MARK: - API
    private let authPlugin: AuthPlugin
    private let provider: MoyaProvider<PlaceRegistService>
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<PlaceRegistService>(plugins: [authPlugin])
    }
    
    //MARK: - Property
    @Published var requestWalwayRegistModel: RequestWalwayRegistModel?
    @Published var isImagePickerPresented = false
    @Published var currentPageIndex: Int = 0
    @Published var navigationToNextView = false
    @Published var images: [UIImage] = []
    @Published var idInt: Int? = 0
    //MARK: - saveTextInputs
    @Published var firstPlaceName: String = ""
    @Published var fourthWalkwayDescription: String = ""
    
    var titleText: String = "산책스팟 등록이 \n완료되었습니다."
    
    var highlightText: String = "산책스팟"

    
    //MARK: - ImageFunction
    /// 앨범 또는 카메라에서 사진을 가져와 추가하는 로직
    /// - Parameter image: 앨범 또는 카메라로 추가한 이미지
    var selectedImageCount: Int {
        images.count
    }
    
    public func imageToBase64String(img: UIImage) -> String? {
        guard let imageData = img.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        return imageData.base64EncodedString()
    }
    
    /// 앨범에서 선택한 이미지 추가하기
    /// - Parameter newImages: 추가한 이미지 배열에 넣기
    public func addImage(_ newImage: UIImage) {
        let resizedWidth: CGFloat = 300
        if let resizedImage = newImage.resized(toWidth: resizedWidth) {
            images.append(resizedImage)
        }
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
    @Published var locationManager = BaseLocationManager.shared
    
    
    /// 현재 버튼을 눌러 위치 활성화하기
    public func searchAddress() {
        if let lat = locationManager.currentLocation?.coordinate.latitude,
           let lng = locationManager.currentLocation?.coordinate.longitude {
            ReverseGeocodingService().fetchReverseGeocodingData(latitude: lat,
                                                                longitude: lng) { [weak self] address in
                self?.address = address ?? "주소를 찾을 수 없습니다."
            }
        }
    }
    
    //MARK: - WalkwayRegistAPI
    
    /// 토큰 불러오기
    /// - Returns: 저장된 토큰 불러온다.
    private func loadAccessToken() -> String? {
        guard let accessToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            return "토큰정보 에러"
        }
        
        return accessToken
    }
    
    /// 장소등록에 사용된 데이터 전부 전달
    private func sendDataWalkwayInfo() {
        
        if let requestWalwayRegistModel = requestWalwayRegistModel {
            provider.request(.sendWalwayInfo(requestWalwayRegistModel, token: loadAccessToken() ?? "토큰정보 없음")) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseWalkwayRegistModel.self, from: response.data)
                        self.idInt = decodedData.information.id
                        print("산책로 등록 완료 후 해독 완료: \(decodedData)")
                    } catch {
                        print("산책로 등록 decoded 에러 : \(error)")
                    }
                case.failure(let error):
                    print("산책로 네트워크 error: \(error)")
                }
            }
        }
    }
    
    private func sendImage() {
        provider.request(.sendWalkwayImage(spotId: self.idInt ?? 0, token: loadAccessToken() ?? "토큰 정보 없음", images: images)) { result in
            switch result {
            case .success(let response ):
                do {
                    let decodedData = try JSONDecoder().decode(WalkImageModel.self, from: response.data)
                    print("산책 등록 이미지 등록 완료 : \(decodedData)")
                } catch {
                    print("산책 등록 이미지 디코더 오류 : \(error)")
                    print("오류 데이터 :  \(response)")
                }
            case.failure(let error) :
                print("산책로 네트워크 에러 : \(error)")
            }
        }
    }
    
    //MARK: - WalkwayDataMatching
    
    private func createParameters() -> RequestWalwayRegistModel {
        return RequestWalwayRegistModel(name: self.firstPlaceName,
                                        dongAreaId: self.address,
                                        detailAddress: self.detailAddress,
                                        info: self.fourthWalkwayDescription,
                                        latitude: self.locationManager.currentLocation?.coordinate.latitude ?? 0.0,
                                        longitude: self.locationManager.currentLocation?.coordinate.longitude ?? 0.0
        )
    }
    
    
    private func matchWalkwayRegisterData() {
        self.requestWalwayRegistModel = createParameters()
    }
    
    
    /// 산책로 버튼
    public func finishPlaceRegist(){
        matchWalkwayRegisterData()
        self.sendDataWalkwayInfo()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.sendImage()
        }
    }
}
