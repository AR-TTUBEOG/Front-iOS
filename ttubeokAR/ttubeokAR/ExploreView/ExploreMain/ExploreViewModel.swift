//
//  ExploreViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation
import CoreLocation

class ExploreViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    
    //MARK: - Property
    @Published var isFavorited: Bool = false
    static var exploreViweModel = ExploreViewModel()
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    // CLLocationManager 인스턴스를 사용
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
            locationManager.location
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



    //위치 관리자를 설정하고 위치 업데이트를 시작
    override init() {
          super.init()
        locationManager.delegate = self // 현재 클래스를 델리게이트로 설정
          locationManager.desiredAccuracy = kCLLocationAccuracyBest//정확도 상승
        locationManager.requestWhenInUseAuthorization() // 위치 서비스 사용 권한 요청
          locationManager.startUpdatingLocation() //위치 업데이트
      }
//
//    //주어진 매장의 위치와 거리, 시간 계산 함수
//     func calculateDistanceAndTime() {
//           
//           guard let currentLocation = locationManager.location else { return }
//
//         let storeLocation = CLLocation(latitude: CLLocationDegrees(ExploreViewModel.ExploreViweModel.distance), longitude: CLLocationDegrees(detailInfo.sampleStoreInfo.longitude))
//           distance = currentLocation.distance(from: storeLocation)
//
//           let walkingSpeedPerMeterPerSecond: Double = 1.4 // 걷기 속도
//           estimatedTime = distance / walkingSpeedPerMeterPerSecond
//       }
//
//    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        calculateDistanceAndTime()
//       }
//
//    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//           // 위치 서비스 권한 변경 시 필요한 작업 수행
//       }
}
