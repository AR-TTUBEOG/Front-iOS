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
    private let provider = MoyaProvider<DetailExploreAPITarget>()
    private let likeProvider = MoyaProvider<ExploreAPITarget>()
    
    //MARK: - Model
    var walkwayDetailDataModel: WalkwayDetailDataModel?
    var storeDetailDataModel: StoreDetailDataModel?
    
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
    
    private func walkWayGet(get place: ExploreDetailInfor) {
        provider.request(.fetchWalkWayDetail(spotId: place.id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(WalkwayDetailDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.walkwayDetailDataModel = decodedData
                    }
                } catch {
                    print("산책로 등록 디코드 에러")
                }
            case.failure(let error):
                print("산책로 네트워크 오류 : \(error.localizedDescription)")
            }
        }
    }
    
    private func storeGet(get place: ExploreDetailInfor) {
        provider.request(.fetchStoreDetail(storeId: place.id)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(StoreDetailDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.storeDetailDataModel = decodedData
                    }
                } catch {
                    print("매장 등록 디코드 에러")
                }
            case .failure(let error):
                print("매장 네트워크 오류: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - 방문하기 버튼
    public func GuestVisitAction() {
        print("방문하기를 눌렀습니다.")
    }
    
    public func GuestBookAction() {
        print("방명록을 작성합니다.")
    }
    
    // MARK: - 방명록 및 좋아요 수
    public func formattedCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    var reviewText: Int {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.guestbook ?? 0
        case .store:
            return storeDetailDataModel?.information.guestbookCount ?? 0
        }
    }
    var likeText: Int {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.likes ?? 0
        case .store:
            return storeDetailDataModel?.information.likeCount ?? 0
        }
    }
    
    
    
    //MARK: - 사진 처리 함수
    
    var images: [String] {
        switch placeType {
        case .spot:
            return walkwayDetailDataModel?.information.image ?? []
        case .store:
            return storeDetailDataModel?.information.image ?? []
        }
    }
    
    public func nextImage() {
        if currentImageIndex < (images.count - 1) {
            currentImageIndex += 1
        }
    }
    
    public func previousImage() {
        if currentImageIndex > 0 {
            currentImageIndex -= 1
        }
    }
    
    //MARK: - 좋아요 버튼
    
    var favoriteImageName: String {
        return isFavorited ? "pressedheart" : "unpressedheart"
    }
    
    public func toggleFavorite() {
        isFavorited.toggle()
        
        if self.isFavorited {
            sendLike()
        }
    }
    
    private func sendLike() {
        switch placeType {
        case .spot:
            likeWalkWay(spotId: walkwayDetailDataModel?.information.id ?? 0)
        case .store:
            likeStore(storeId: storeDetailDataModel?.information.storeId ?? 0)
        }
    }
    
    private func likeWalkWay(spotId: Int) {
        likeProvider.request(.likeWalkWay(spotId: spotId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(WalkWayLikeModel.self, from: response.data)
                    print(decodedResponse)
                } catch {
                    print("산책로 error")
                }
            case .failure(let error):
                print("산책로 error : \(error)")
            }
        }
    }
    
    private func likeStore(storeId: Int) {
        likeProvider.request(.likeStoreData(storeId: storeId)) { result in
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
        if let storeBenefit = storeDetailDataModel?.information.benefit {
            switch benefitName {
            case "gift":
                return storeBenefit.contains("GIFT") ? Icon.checkGift.image : Icon.nonGift.image
            case "sale":
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
    
    private func typeDistanceAndTime() {
        switch placeType {
        case .spot:
            walWayCalculateDistanceAndTime()
        case .store:
            marketCalculateDistanceAndTime()
        }
    }
    
    private func marketCalculateDistanceAndTime() {
        guard let currentLocation = locationManager.location else { return }
        
        // 배열의 첫 번째 장소 정보를 사용
        if let marketCalculateDistance = storeDetailDataModel?.information {
            let storeLocation = CLLocation(latitude: CLLocationDegrees(marketCalculateDistance.latitude), longitude: CLLocationDegrees(marketCalculateDistance.longitude))
            let distance = currentLocation.distance(from: storeLocation)
            let marketSpeedPerMeterPerSecond: Double = 1.4 // 걷기 속도
            self.estimatedTime = distance / marketSpeedPerMeterPerSecond
        }
    }
    
    private func walWayCalculateDistanceAndTime() {
        guard let currentLocation = locationManager.location else { return }
        
        // 배열의 첫 번째 장소 정보를 사용
        if let marketCalculateDistance = walkwayDetailDataModel?.information {
            let storeLocation = CLLocation(latitude: CLLocationDegrees(marketCalculateDistance.latitude), longitude: CLLocationDegrees(marketCalculateDistance.longitude))
            let distance = currentLocation.distance(from: storeLocation)
            let walkingSpeedPerMeterPerSecond: Double = 1.4 // 걷기 속도
            self.estimatedTime = distance / walkingSpeedPerMeterPerSecond
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        typeDistanceAndTime()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    // MARK: - distance Fuction
    
    //위치 관리자를 설정하고 위치 업데이트를 시작
    override init() {
        super.init()
        locationManager.delegate = self // 현재 클래스를 델리게이트로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//정확도 상승
        locationManager.requestWhenInUseAuthorization() // 위치 서비스 사용 권한 요청
        locationManager.startUpdatingLocation() //위치 업데이트
    }
}
