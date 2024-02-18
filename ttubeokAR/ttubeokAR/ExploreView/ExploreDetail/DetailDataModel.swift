//
//  DetailViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation

//매장 세부사항 조회 api
struct WalkwayDetailDataModel: Codable {
    var check: Bool
    var information: WalwayInformation
}

struct WalwayInformation: Codable {
    var spotId: Int
    var memberId: Int
    var name: String
    var info: String
    var dongAreaId: String
    var detailAddress: String
    var latitude: Double
    var longitude: Double
    var stars: Float
    var guestbookCount: Int
    var likesCount: Int
    var isFavorited : Bool
    var image: String
}

struct WalkImageModel: Codable {
    var check: Bool
    var information: [WalkDetailImage]
}

struct WalkDetailImage: Codable {
    var id: Int
    var uuid: String
    var image: String
    var imageType: String
    var placeId: Int
}

//MARK: - 매장 등록

struct StoreDetailDataModel: Codable {
    var check: Bool
    var information: StoreInformation
}

struct StoreInformation: Codable {
    var storeId: Int
    var memberId: Int
    var name: String
    var info: String
    var dongAreaId: String
    var detailAddress: String
    var latitude: Double
    var longitude: Double
    var image: [String]
    var stars: Float
    var type: StoreType
    var storeBenefits: [String]
    var guestbookCount: Int
    var likesCount: Int
    var isFavorited: Bool
}

struct StoreImageModel: Codable {
    var check: Bool
    var information: [StoreDetailImage]
}

struct StoreDetailImage: Codable {
    var id: Int
    var uuid: String
    var image: String
    var imageType: String
    var placeId: Int
}

enum StoreType: String, Codable {
    case RESTAURANT
    case CAFE
}
