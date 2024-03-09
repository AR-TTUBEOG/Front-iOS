//
//  RecommendedSpaceCardViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/15/24.
//

import Foundation
import CoreLocation
import Moya
import SwiftUI

class IndividualSpaceCardViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    //MARK: - API
    private let authPlugin: AuthPlugin
    private let provider: MoyaProvider<ExploreAPITarget>
    var exploreDetailInfor: ExploreDetailInfor?
    
    init(exploreDetailInfor: ExploreDetailInfor) {
        self.exploreDetailInfor = exploreDetailInfor
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<ExploreAPITarget>(plugins: [authPlugin])
    }
    
    //MARK: - 이미지 좋아요
    @Published var placeType: PlaceTypeValue? = nil
    @Published var placeImage: String = ""
    
    
    public func sendLike() {
        
        if (self.exploreDetailInfor?.placeType.spot ?? false) {
            self.likeWalkWay(spotId: self.exploreDetailInfor?.placeId ?? 0)
        } else if (self.exploreDetailInfor?.placeType.store ?? false) {
            self.likeStore(storeId: self.exploreDetailInfor?.placeId ?? 0)
        }
    }
    
    public func likeWalkWay(spotId: Int) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.likeWalkWay(spotId: spotId, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(WalkWayLikeModel.self, from: response.data)
                    print("산책로 좋아요 누름 : \(decodedResponse.information.message)")
                } catch {
                    print("산책로 error")
                }
            case .failure(let error):
                print("산책로 error : \(error)")
            }
        }
    }
    
    public func likeStore(storeId: Int) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.likeStoreData(storeId: storeId, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(StoreLikeModel.self, from: response.data)
                    print("매장 좋아요 누름 : \(decodedResponse.information.message)")
                } catch {
                    print("매장 error : \(error)")
                }
            case .failure(let error):
                print("매장 error: \(error)")
            }
        }
    }
    
    //MARK: - 거리 및 시간 계산
    
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    
    
    public func updateDistanceAndTIme() {
        guard let currentLocation = BaseLocationManager.shared.currentLocation,
              let destinationLat = exploreDetailInfor?.latitude,
              let destinationLng = exploreDetailInfor?.longitude else {
            return
        }
        
        let destinationLocation = CLLocation(latitude: destinationLat, longitude: destinationLng)
        let distance = currentLocation.distance(from: destinationLocation)
        self.distance = distance
        
        let averageSpeed = 5.0
        let estimatedTime = distance / (averageSpeed * 1000) * 3600
        self.estimatedTime = estimatedTime
        
        print("현재 거리 차이 : \(distance)")
    }
    
    
    
    public func walkImageGet() {
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        print("스팟 아이디 : \(exploreDetailInfor?.placeId)")
        
        provider.request(.getWalkImage(spotId: self.exploreDetailInfor?.placeId ?? 0, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(PlaceImageCheck.self, from: response.data)
                    self.placeImage = decodedData.information[0].image
                    print("산책 스팟 사진 불러오기 완료")
                } catch {
                    print("사진 스팟 사진 디코더 에러 : \(error)")
                }
            case .failure(let error):
                print("산책스팟 에러: \(error)")
            }
        }
    }
    
    
    public func storeImageGet() {
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.getStoreImage(spotId: self.exploreDetailInfor?.placeId ?? 0, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(PlaceImageCheck.self, from: response.data)
                    self.placeImage = decodedData.information[0].image
                    print("매장 사진 불러오기 완료")
                } catch {
                    print("매장 사진 디코더 에러 : \(error)")
                }
            case .failure(let error):
                print("매장 에러: \(error)")
            }
        }
    }
    
    
}
