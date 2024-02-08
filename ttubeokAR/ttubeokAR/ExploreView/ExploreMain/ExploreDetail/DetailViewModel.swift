//
//  DetailViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/26/24.
//

import Foundation
import CoreLocation
import Moya

class DetailViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    // MARK: - Property
    @Published var isFavorited: Bool = false
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    // CLLocationManager 인스턴스를 사용
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        locationManager.location
    }
    private let provider = MoyaProvider<DetailExploreAPITarget>()
    private let providerBook = MoyaProvider<ExploreAPITarget>()
    var exploreDetailData: DetailDataModel? // 산책로
    //var exploreDetailData: DetailDataModel? // 매장
    
    // MARK: - Function
    func GuestVisitAction() {
        print("방문하기를 눌렀습니다.")
    }
    
    func GuestBookAction() {
        print("방명록을 작성합니다.")
    }
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    var favoriteImageName: String {
        return isFavorited ? "pressedheart" : "unpressedheart"
    }
    
    public func toggleFavorite() {
        isFavorited.toggle()
        if isFavorited {
            //TODO: - 좋아요 post 날리기
            print("북마크 버튼이 눌렸습니다.")
        } else {
            print("북마크 취소 버튼이 눌렸습니다.")
        }
    }
    
    private func sendFavorite() {
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
    
    //주어진 매장의 위치와 거리, 시간 계산 함수
    func calculateDistanceAndTime() {
        guard let currentLocation = locationManager.location else { return }
        
        // 배열의 첫 번째 장소 정보를 사용
        if let firstSpaceInfo = exploreDetailData?.information.first {
            let storeLocation = CLLocation(latitude: CLLocationDegrees(firstSpaceInfo.latitude), longitude: CLLocationDegrees(firstSpaceInfo.longitude))
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
    }
    
    
    
    // MARK: - APIViewModel
    // DetailDataModel를 서버로부터 받아오는 함수
    public func fetchExploreDetail(storeId: Int, completion: @escaping (Result<DetailDataModel, Error>) -> Void) {
        provider.request(.fetchExploreDetail(storeId: storeId)) { result in
            switch result {
            case .success(let response):
                do {
                    let responseData = try JSONDecoder().decode(DetailDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.exploreDetailData = responseData
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
