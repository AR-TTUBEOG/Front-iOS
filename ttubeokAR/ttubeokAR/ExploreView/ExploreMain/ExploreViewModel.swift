//
//  ExploreViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation
import CoreLocation
import Moya

enum PlaceTypeValue {
    case spot
    case store
    case none
}

class ExploreViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    //MARK: - API
    
    private let provider = MoyaProvider<ExploreAPITarget>()
    
    //MARK: - Moodel
    var exploreData: ExploreDataModel?
    var likeModel: LikeModel?
    var exploreDetailInfor: ExploreDetailInfor?
    
    //MARK: - Property
    private var locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        locationManager.location
    }
    
    @Published var isFavorited: Bool = false
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    @Published var placeType: PlaceTypeValue = .none
    
    
    
    
    
    // 서버로부터 ExploreDataModel 데이터를 받아오는 함수
    func fetchExploreData() {
        provider.request(.fetchExploreData) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.exploreData = decodedData
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            case .failure(let error):
                print("Network error: \(error)")
            }
        }
    }
    
    // MARK: - BookMarkAPI
    //찜버튼 api 함수
    func bookmarkSpace(storeId: Int, completion: @escaping (Result<Bool, MoyaError>) -> Void) {
        providerMark.request(.bookmarkSpace(storeId:storeId)) { result in
            switch result {
            case .success(let _response):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: - ChangeExploreView
    
    var favoriteImageName: String {
        return isFavorited ? "Vector2" : "Vector"
    }
    
    
    
    
    // MARK: - 장소 좋아요 호출 함수

    /// 장소 타입에 따른 API 호출
    public func checkLike() {
        
        if self.isFavorited {
            sendLike()
        } else {
            print("이렇게 해두기")
        }
    }
    
    private func sendLike() {
        switch self.placeType {
        case .spot:
            // 산책로 API
        case .store:
            // 매장 API
        case .none:
            print("error")
        }
    }
    
    //TODO: - 산책로 API 호출
    
    
    //TODO: - 매장 API 호출
    
    
    // MARK: - Function
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    func getPlaceTypeText(for place: Place?) -> String {
        guard let place = place else {
            return "Unknown"
        }
        return "SomeString"
    }
    
    // MARK: - Distance Function
    
    //위치 관리자를 설정하고 위치 업데이트를 시작
    override init() {
        super.init()
        locationManager.delegate = self // 현재 클래스를 델리게이트로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//정확도 상승
        locationManager.requestWhenInUseAuthorization() // 위치 서비스 사용 권한 요청
        locationManager.startUpdatingLocation() //위치 업데이트
    }
    
    //주어진 매장의 위치와 거리, 시간 계산 함수
    private func calculateDistanceAndTime() {
        guard let currentLocation = locationManager.location else { return }
        
        // 배열의 첫 번째 장소 정보를 사용
        if let spaceInfo = exploreDetailInfor {
            let storeLocation = CLLocation(latitude: CLLocationDegrees(spaceInfo.latitude), longitude: CLLocationDegrees(spaceInfo.longtitude))
            let distance = currentLocation.distance(from: storeLocation)
            
            let walkingSpeedPerMeterPerSecond: Double = 1.4 // 걷기 속도
            estimatedTime = distance / walkingSpeedPerMeterPerSecond
            // 여기서 estimatedTime을 사용하거나 업데이트 하는 로직 추가
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        calculateDistanceAndTime()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        // 위치 서비스 권한 거부 시 필요한 작업 수행
    }
    
}

