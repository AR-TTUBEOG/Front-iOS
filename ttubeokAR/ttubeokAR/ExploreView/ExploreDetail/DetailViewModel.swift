//
//  DetailViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/26/24.
//

import Foundation
import CoreLocation
import Moya
import SwiftUI

class DetailViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    
    //MARK: - API
    
    private let authPlugin: AuthPlugin
    private let provider: MoyaProvider<DetailExploreAPITarget>
    private let likeProvider: MoyaProvider<ExploreAPITarget>
    
    override init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<DetailExploreAPITarget>(plugins: [authPlugin])
        self.likeProvider = MoyaProvider<ExploreAPITarget>(plugins: [authPlugin])
    }
    
    //MARK: - Model
    @Published var walkwayDetailDataModel: WalkwayDetailDataModel?
    @Published var walkwayImageModel: WalkImageModel?
    @Published var storeDetailDataModel: StoreDetailDataModel?
    @Published var storeImageModel : StoreImageModel?
    @Published var guestBookModel: GuestBookModel?
    
    // MARK: - Property
    @Published var isFavorited: Bool = false
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    @Published var currentImageIndex = 0
    
    var locationManager = CLLocationManager()
    var placeType: PlaceTypeValue = .spot
    var currentLocation: CLLocation? {
        locationManager.location
    }
    
    //MARK: - API Fetch 함수
    /// 장소 타입에 맞춰 API 호출
    /// - Parameter place: 전달 받은 장소 타입
    public func fetchDetails(for place: ExploreDetailInfor) {
        if place.placeType.spot {
            self.placeType = .spot
            walkWayGet(get: place)
        }
        else if place.placeType.store {
            self.placeType = .store
            storeGet(get: place)
        }
    }
    
    //MARK: - 산책로 상세 조회 처리
    
    /// 선택한 산책로 데이터를 가져온다.
    /// - Parameter place: 선택한 산책로 정보
    private func walkWayGet(get place: ExploreDetailInfor) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.fetchWalkWayDetail(spotId: place.placeId, token: accessToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(WalkwayDetailDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.walkwayDetailDataModel = decodedData
                        self?.walkWayImage(get: self?.walkwayDetailDataModel?.information.spotId ?? 0)
                        print("디테일 산책로 조회 완료")
                    }
                } catch {
                    print("디테일 산책로 등록 디코드 에러: \(error)")
                }
            case.failure(let error):
                print("디테일 산책로 네트워크 오류 : \(error.localizedDescription)")
            }
        }
    }
    
    /// 산책로의 이미지들을 얻어와 이미지 데이터 모델을 채운다.
    /// - Parameter place: 선택한 장소의 정보 전달
    private func walkWayImage(get walkWayId: Int) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.fetchWalkWayImage(spotId: walkWayId, token: accessToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(WalkImageModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.walkwayImageModel = decodedData
                        print("산책로 이미지 불러오기 완료")
                    }
                }
                catch {
                   print("산책로 이미지 디코더 오류 : \(error)")
                }
            case .failure(let error):
                print("산책로 이미지 네트워크 오류 : \(error)")
            }
        }
    }
    
    //MARK: - 매장 상세 조회 처리
    
    /// 매장 상세 데이터 조회
    /// - Parameter place: 장소 타입
    private func storeGet(get place: ExploreDetailInfor) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.fetchStoreDetail(storeId: place.placeId, token: accessToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(StoreDetailDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.storeDetailDataModel = decodedData
                        self?.storeImage(get: self?.storeDetailDataModel?.information.storeId ?? 0)
                        print("디테일 매장 등록")
                    }
                } catch {
                    print("디테일 매장 등록 디코드 에러 : \(error)")
                }
            case .failure(let error):
                print("디텥일 매장 네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
    
    private func storeImage(get place: Int) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        provider.request(.fetchStoreImage(storeId: place, token: accessToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(StoreImageModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.storeImageModel = decodedData
                        print("매장 이미지 불러오기 완료")
                    }
                }
                catch {
                   print("매장 이미지 디코더 오류 : \(error)")
                }
            case .failure(let error):
                print("매장 이미지 네트워크 오류 : \(error)")
            }
        }
    }
    
    // MARK: - 방문하기 버튼
    
    //TODO: - 방문하기 버튼 클릭 시 액션 값 넣기
    /// 방문하기 버튼 클릭시 행동
    public func GuestVisitAction() {
        print("방문하기를 눌렀습니다.")
    }
    
    public func GuestBookAction() {
        print("방명록을 작성합니다.")
    }
    
    // MARK: - 방명록 및 좋아요 수
    
    /// 좋아요 및 방명록 수 999개 까지
    /// - Parameter count: int 값
    /// - Returns: 갯수 출력
    public func formattedCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    /// 저장된 데이터 모델에 맞춰 카운트 출력
    var reviewText: Int {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.guestbookCount ?? 0
        case .store:
            return storeDetailDataModel?.information.guestbookCount ?? 0
        }
    }
    
    /// 저장된 데이터 모델에 맞춰 좋아요 수 출력
    var likeText: Int {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.likesCount ?? 0
        case .store:
            return storeDetailDataModel?.information.likesCount ?? 0
        }
    }
    
    //MARK: - 좋아요 버튼
    
    /// 좋아요 버튼 이미지
    var favoriteImageName: String {
        return isFavorited ? "pressedheart" : "unpressedheart"
    }
    
    public func toggleFavorite() {
        isFavorited.toggle()
        
        if self.isFavorited {
            sendLike()
        }
    }
    
    /// 좋아요 API 전송 버튼,
    private func sendLike() {
        switch placeType {
        case .spot:
            likeWalkWay(spotId: walkwayDetailDataModel?.information.spotId ?? 0)
        case .store:
            likeStore(storeId: storeDetailDataModel?.information.storeId ?? 0)
        }
    }
    
    /// 좋아요 버튼 클릭
    /// - Parameter spotId: 해당 장소의 id
    private func likeWalkWay(spotId: Int) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        likeProvider.request(.likeWalkWay(spotId: spotId, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(WalkWayLikeModel.self, from: response.data)
                    print("좋아요 버튼 클릭 후 호출 : \(decodedResponse)")
                } catch {
                    print("산책로 error")
                }
            case .failure(let error):
                print("산책로 error : \(error)")
            }
        }
    }
    
    /// 매장 좋아요 버튼 클릭
    /// - Parameter storeId: 해당 장소의 id
    private func likeStore(storeId: Int) {
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else { return }
        
        likeProvider.request(.likeStoreData(storeId: storeId, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(StoreLikeModel.self, from: response.data)
                    print(decodedResponse)
                } catch {
                    print("매장 error")
                }
            case .failure(let error):
                print("매장 error: \(error)")
            }
        }
    }
    
    //MARK: - 장소 이름
    
    var title: String {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.name ?? ""
        case .store:
            return storeDetailDataModel?.information.name ?? ""
        }
    }
    
    
    //MARK: - 장소 혜택 처리 함수
    
    private func storeImage(benefitName: String) -> SwiftUI.Image {
        if let storeBenefit = storeDetailDataModel?.information.storeBenefits {
            switch benefitName {
            case "GIFT":
                return storeBenefit.contains("GIFT") ? Icon.checkGift.image : Icon.nonGift.image
            case "SALE":
                return storeBenefit.contains("SALE") ? Icon.checkCoupon.image : Icon.nonCoupon.image
            default:
                return storeBenefit.contains("PLUS") ? Icon.onePlusOne.image : Icon.unOnePlus.image
            }
        } else {
            return Image(systemName: "photo")
        }
    }
    
    var gitBeneft: SwiftUI.Image {
        switch placeType {
        case .spot:
            return Icon.nonGift.image
        case .store:
            return storeImage(benefitName: "GIFT")
        }
    }
    
    var saleBenefit: SwiftUI.Image {
        switch placeType {
        case .spot:
            return Icon.nonCoupon.image
        case .store:
            return storeImage(benefitName: "SALE")
        }
    }
    
    var plusBenefit: SwiftUI.Image {
        switch placeType {
        case .spot:
            return Icon.unOnePlus.image
        case .store:
            return storeImage(benefitName: "PLUS")
        }
    }
    
    //MARK: - 장소 설명
    
    var spaceDescript: String {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.info ?? ""
        case .store:
            return storeDetailDataModel?.information.info ?? ""
        }
    }
    
    //MARK: - 장소 별점 및 위도, 경도
    
    var sapceStartPoint: Float {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.stars ?? 0.0
        case .store:
            return storeDetailDataModel?.information.stars ?? 0.0
        }
    }
    
    public func typeDistanceAndTime() {
        switch placeType {
        case .spot:
            walWayCalculateDistanceAndTime()
        case .store:
            marketCalculateDistanceAndTime()
        }
    }
    
    
    //MARK: - 거리 및 시간 계산
    
    
    /// 가게 등록 시간 및 거리
    private func marketCalculateDistanceAndTime() {
        
        guard let currentLocation = BaseLocationManager.shared.currentLocation,
              let destinationLat = storeDetailDataModel?.information.latitude,
              let destinationLng = storeDetailDataModel?.information.longitude else {
            return
        }
        
        // 배열의 첫 번째 장소 정보를 사용
        let storeLocation = CLLocation(latitude: CLLocationDegrees(destinationLat), longitude: CLLocationDegrees(destinationLng))
        let distance = currentLocation.distance(from: storeLocation)
        self.distance = distance
        
        let averageSpeed = 5.0
        self.estimatedTime = distance / (averageSpeed * 1000) * 3600
        self.estimatedTime = estimatedTime
    }
    
    /// 산책로 등록 시간 및 거리
    private func walWayCalculateDistanceAndTime() {
        
        guard let currentLocation = BaseLocationManager.shared.currentLocation,
              let destinationLat = walkwayDetailDataModel?.information.latitude,
              let destinationLng = walkwayDetailDataModel?.information.longitude else {
            return
        }
        
        let walkLocation  = CLLocation(latitude: CLLocationDegrees(destinationLat), longitude: CLLocationDegrees(destinationLng))
        let distance = currentLocation.distance(from: walkLocation)
        self.distance = distance
        
        let averageSpeed = 5.0
        self.estimatedTime = distance / (averageSpeed * 1000) * 3600
        self.estimatedTime = estimatedTime
    }
    
}
