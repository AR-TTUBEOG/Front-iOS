//
//  PlaceSettingModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/14/24.
//

import Foundation

struct PlaceSettingsModel {
    var selectionPlace: PlaceType
    var distance: Double
}

enum PlaceType: String, CaseIterable {
    case all = "전체선택"
    case walkingTrail = "산책로"
    case cafe = "카페"
    case restaurant = "음식점"
}
