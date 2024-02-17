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
    let placeId: Int
    let placeType: PlaceType
    let dongName: String?
    let memberId: Int?
    let name: String?
    let info: String?
    let latitude: Double?
    let longitude: Double?
    let image: String? // 옵셔널 타입으로 선언, JSON에서 null 일 수 있음
    let stars: Double?
    let guestbookCount: Int?
    let likesCount: Int?
    let isFavorited: Bool?
    let createdAt: String?
    let recommendationScore: Int?
    let distance: Double? // 옵셔널 타입으로 선언, JSON에서 null 일 수 있음
    let hasGame: Bool?
}

struct PlaceType: Codable, Hashable {
    let store: Bool
    let spot: Bool
}

//MARK: - 산책로 좋아요 모델 데이터
struct WalkWayLikeModel: Codable {
    var check: Bool
    var information: WalkWayLikeInfor
}

struct WalkWayLikeInfor: Codable {
    var message: String
}

//MARK: - 매장 좋아요 모델 데이터
struct StoreLikeModel: Codable {
    var check: Bool
    var information: StoreLikeInfor
}

struct StoreLikeInfor: Codable {
    var message: String
}



class dataEx {
    let data = ExploreDetailInfor(placeId: 1, placeType: PlaceType(store: true, spot: false), dongName: "흑석동", memberId: 2, name: "유하하", info: "재밌지요", latitude: 1.1, longitude: 1.1, image: "mapPlaceExample", stars: 1.0, guestbookCount: 123, likesCount: 100, isFavorited: false, createdAt: "1111", recommendationScore: 20, distance: 10, hasGame: false)
}
