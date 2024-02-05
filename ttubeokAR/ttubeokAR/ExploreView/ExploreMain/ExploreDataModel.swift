//
//  RecommendSpaceModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation

//전체 장소 조회 api
struct ExploreDataModel: Codable {
    var check: Bool
    var information: [ExploreDetailInfor]
}

struct ExploreDetailInfor: Codable {
    var id: Int // 징소아이디
    var place: [PlacePurpose]
    var memberId: Int //등록 유저 id
    var name: String
    var latitude: Double
    var longtitude: Double
    var image: String
    var stars: Int
    var guestbookCount: Int
    var isFavorited: Bool
}

struct PlacePurpose: Codable {
    var store: Bool
    var spot: Bool
}
