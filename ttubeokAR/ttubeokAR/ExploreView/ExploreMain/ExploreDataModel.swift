//
//  RecommendSpaceModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation

//MARK: - 전체 장소 모델 데이터
struct ExploreDataModel: Codable{
    
    var check: Bool
    var information: [ExploreDetailInfor]
}

struct ExploreDetailInfor: Codable, Hashable {
    var id: Int // 징소아이디
    var placeType: PlacePurpose
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

//MARK: - 산책로 좋아요 모델 데이터
struct WalkWayLikeModel: Codable {
    var check: Bool
    var information: WalkWayLikeInfor
}

struct WalkWayLikeInfor: Codable {
    var likedId: Int
    var spotId: Int
    var userId: Int
}

//MARK: - 매장 좋아요 모델 데이터
struct StoreLikeModel: Codable {
    var check: Bool
    var information: StoreLikeInfor
}

struct StoreLikeInfor: Codable {
    var message: String
}
