//
//  PlaceSettingsViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/14/24.
//

import Foundation

class PlaceSettingsViewModel: ObservableObject {
    //MARK: - Property
    let maxSliderValue = 100.0
    @Published var selectPlace: SearchPlaceType? = nil
    
    //TODO: - 수정하기
    @Published var settings = PlaceSettingsModel(selectionPlace: .all)
    @Published var distanceValue: Double = 5.0
    
    var distanceDisplay: String {
        String(format: "%.1f km", self.distanceValue)
    }
    
    //MARK: - Function
    
    //슬라이더 거리 게산 로직
    public func calculateDistance(for sliderValue: Double) -> Double {
        switch sliderValue {
        case 0..<25:
            return sliderValue / 25.0 * 1.0
        case 25..<50:
            return 1.0 + (sliderValue - 25.0) / 25.0 * 2.0
        case 50..<75:
            return 5.0 + (sliderValue - 50.0) / 25.0 * 2.0
        case 75..<100:
            return 5.0 + (sliderValue - 75.0) / 25.0 * 5.0
        default:
            return 10.0
        }
    }
    
    //버튼에 따른 장소 값
    public func updateSelectionPlace(_ place: SearchPlaceType) {
        settings.selectionPlace = place
    }
    
    //슬라이더 값에 따른 새로운 거리 값
    public func updateDistance(_ newDistance: Double) {
        self.distanceValue = calculateDistance(for: newDistance)
    }
    
    
    //서버에 설정 업데이트 요처
    public func updateSetting() {
        postSettingToServer(settings)
    }
    
    //Moya로 요청 필요
    private func postSettingToServer(_ settings: PlaceSettingsModel) {
        // 서버 post 요청
    }
}
