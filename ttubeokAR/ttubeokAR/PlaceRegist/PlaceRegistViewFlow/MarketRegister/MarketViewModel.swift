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
import CoreLocation
import PhotosUI


class MarketViewModel: ObservableObject, ImageHandling, InputAddressProtocol, FinishViewProtocol {
    
    
    //MARK: - API
    private let authPlugin: AuthPlugin
    private let provider: MoyaProvider<PlaceRegistService>
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<PlaceRegistService>(plugins: [authPlugin])
    }
    
    @Published var storeId: Int = 0 {
            didSet {
                basketBallViewModel.storeId = storeId
                giftViewModel.storeId = storeId
                wheelGameViewModel.storeId = storeId
            }
        }
    
    //MARK: - ViewModel
    @Published public var basketBallViewModel = BasketBallGameViewModel()
    @Published public var giftViewModel = GiftDrawingGameViewModel()
    @Published public var wheelGameViewModel = WheelGameViewModel()
    
    //MARK: - Property
    @Published var marketModel = MarketModel()
    @Published var requestStoreRegistModel: RequestMarketRegistModel?
    @Published var currentPageIndex: Int = 0
    @Published var isImagePickerPresented = false
    @Published var navigationToNextView = false
    @Published var images: [UIImage] = []
    var base64Images: [String] = []
    
    
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
    
    public func addImage(_ newImage: UIImage) {
        let resizedWidth: CGFloat = 720
        if let resizedImage = newImage.resized(toWidth: resizedWidth) {
            images.append(resizedImage)
        }
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
    
    
    //MARK: - CurrentAddress
    
    @Published var address: String = ""
    @Published var detailAddress: String = ""
    @Published var locatoinManager = BaseLocationManager.shared
    
    public func searchAddress() {
        if let lat = locatoinManager.currentLocation?.coordinate.latitude,
           let lng = locatoinManager.currentLocation?.coordinate.longitude {
            ReverseGeocodingService().fetchReverseGeocodingData(latitude: lat, longitude: lng) { [weak self] address in
                DispatchQueue.main.async {
                    self?.address = address ?? "주소를 찾을 수 없습니다."
                }
            }
        }
    }
    
    //MARK: - 토큰 불러오기
    /// 액세스 토큰 불러오기
    /// - Returns: 햔재 액세스 토큰
    private func loadAccessToken() -> String? {
        guard let accessToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            return "토큰 정보 에러"
        }
        
        return accessToken
    }
    
    //MARK: - 장소등록 API
    
    /// 이미지 base64로 전환하기
    private func saveStringImage() {
        for image in images {
            if let base64String = imageToBase64String(img: image) {
                base64Images.append(base64String)
            }
        }
    }
    
    public func imageToBase64String(img: UIImage) -> String? {
        guard let imageData = img.jpegData(compressionQuality: 1.0) ?? img.pngData() else {
            return nil
        }
        return imageData.base64EncodedString()
    }
    
    
    
    private func sendDataMarketInfo() {
        
        if let requestStoreRegistModel = requestStoreRegistModel {
            provider.request(.sendStoreInfo(requestStoreRegistModel, token: loadAccessToken() ?? "토큰 정보 없음")) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseMarketRegistModel.self, from: response.data)
                        self.storeId = decodedData.information.storeId ?? 0
                        print("마켓 등록 완료 : \(decodedData)")
                    } catch {
                        print("마켓 등록 decoded 에러 : \(error)")
                    }
                case .failure(let error):
                    print("산책로 네트워크 error: \(error)")
                }
            }
        }
    }
    
    private func sendImage() {
        provider.request(.sendStoreImage(storeId: self.storeId , token: loadAccessToken() ?? "토큰 정보 없음", images: images)) { result in
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
    
    
    private func creatParameters() -> RequestMarketRegistModel {
        return RequestMarketRegistModel(name: self.firstMarketName,
                                        info: self.fifthMarketDescription,
                                        dongAreaId: self.address,
                                        detailAddress: self.detailAddress,
                                        latitude: self.locatoinManager.currentLocation?.coordinate.latitude ?? 0.0,
                                        longitude: self.locatoinManager.currentLocation?.coordinate.longitude ?? 0.0,
                                        image: ["xx"],
                                        type: self.thirdMarketTypeName

        )
    }
    
    /// 데이터 매칭
    private func mathStoreRegistData() {
        saveStringImage()
        self.requestStoreRegistModel = creatParameters()
    }
    
    /// 마켓 등록 최종 버튼(게임 등록)
    public func finishPlaceRegist() {
        self.basketBallViewModel.finishSendAPI()
        self.giftViewModel.finishSendAPI()
        self.wheelGameViewModel.finishSendAPI()
    }
    
    public func saveInfoMarket() {
        mathStoreRegistData()
        sendDataMarketInfo()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.sendImage()
        }
    }
}

