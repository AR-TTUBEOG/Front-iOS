//
//  ExploreViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation
import CoreLocation
import Moya

class ExploreViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    //MARK: - API
    private let provider = MoyaProvider<ExploreAPITarget>()
    private let searchProvider = MoyaProvider<SearchAPITarget>()
    
    //MARK: - Moodel
    
    var exploreData: ExploreDataModel?
    var exploreDetailInfor: ExploreDetailInfor?
    
    //MARK: - Property
    private var locationManager = CLLocationManager()
    
    var currentLocation: CLLocation? {
        locationManager.location
    }
    
    var favoriteImageName: String {
        return isFavorited ? "checkHeart" : "unCheckHeart"
    }
    
    var curretnPage = 1
    
    @Published var isFavorited: Bool = false
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    @Published var placeType: PlaceTypeValue? = nil
    @Published var currentSearchType: SearchType = .all
    
    
    
    
    // MARK: - 장소 좋아요 호출 함수
    
    /// 장소 타입에 따른 API 호출
    public func checkLike() {
        if self.isFavorited {
            sendLike()
        }
    }
    
    /// 장소 타입에 따라 좋아요 버튼 작동
    private func sendLike() {
        
        guard let detailInfo = exploreDetailInfor else { return }
        
        switch self.placeType {
        case .spot:
            likeWalkWay(spotId: detailInfo.id)
        case .store:
            likeStore(storeId: detailInfo.id)
        case .none:
            print("error")
        }
    }
    
    
    /// 산책로 좋아요 버튼 API 호출
    /// - Parameter spotId: 산책로 아이디 제공할 것
    private func likeWalkWay(spotId: Int) {
        provider.request(.likeWalkWay(spotId: spotId)) { result in
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
        provider.request(.likeStoreData(storeId: storeId)) { result in
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
    // MARK: - 페이징
    
    public func decisionSearchType(_ searchType: SearchType) {
        switch searchType {
        case .all:
            self.currentSearchType = .all
        case .latest:
            self.currentSearchType = .latest
        case .distance:
            self.currentSearchType = .distance
        case .recommended:
            self.currentSearchType = .recommended
        }
    }
    
    public func fetchDateSearch(_ searchType: SearchType, page: Int) {
        switch searchType {
        case .all:
            fetchExploreDataAll(page: page)
        case .latest:
            fetchExploreDataLatest(page: page)
        case .distance:
            fetchExploreDataDistance(page: page)
        case .recommended:
            fetchExploreDataRecommend(page: page)
        }
        self.curretnPage = page
    }
    
    //MARK: - 검색 타입에 따른 API 호출 함수
    
    public func resetPage() {
        curretnPage = 1
    }
    
    public func fetchExploreDataAll(page: Int) {
        searchProvider.request(.searchAll(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("전체선택 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("전체 선택네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataLatest(page: Int) {
        searchProvider.request(.searchLatest(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("최신순 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("최신순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataDistance(page: Int) {
        searchProvider.request(.searchDistance(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("거리순 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("거리순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataRecommend(page: Int) {
        searchProvider.request(.searchRecommend(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("추천순 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("추천순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    
    
    // MARK: - Function
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
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
            self.estimatedTime = distance / walkingSpeedPerMeterPerSecond
            self.distance = distance
        }
    }
    //
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
