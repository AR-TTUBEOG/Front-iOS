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
    //MARK: - Property
    
    private let provider = MoyaProvider<ExploreAPITarget>()
    var exploreData: ExploreDataModel?
    @Published var isFavorited: Bool = false
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    private var locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
            locationManager.location
        }
    
    
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
    
    
    
    // MARK: - ChangeExploreView
    
    var favoriteImageName: String {
          return isFavorited ? "Vector2" : "Vector"
      }
    
    
    
    
    // MARK: - Function
    public func toggleFavorite() {
            isFavorited.toggle()
            if isFavorited {
                print("북마크 버튼이 눌렸습니다.")
            } else {
                print("북마크 취소 버튼이 눌렸습니다.")
            }
        }
    
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
    func calculateDistanceAndTime() {
           guard let currentLocation = locationManager.location else { return }
           
           // 배열의 첫 번째 장소 정보를 사용
        if let firstSpaceInfo = exploreData?.information.first {
               let storeLocation = CLLocation(latitude: CLLocationDegrees(firstSpaceInfo.latitude), longitude: CLLocationDegrees(firstSpaceInfo.longtitude))
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

