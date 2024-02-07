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

struct ExploreDetailInfor: Codable, Hashable {
    var storeId: Int // 징소아이디
    var place: PlacePurpose
    var memberId: Int //등록 유저 id
    var name: String
    var latitude: Double
    var longtitude: Double
    var image: String
    var stars: Double
    var guestbookCount: Int
    var isFavorited: Bool
}

struct PlacePurpose: Codable, Hashable {
    var store: Bool
    var spot: Bool
}


struct LikeModel: Codable {
    var check: Bool
    var information: LikeInfor
}

struct LikeInfor: Codable {
    var likedId: Int
    var spotId: Int
    var userId: Int
}
