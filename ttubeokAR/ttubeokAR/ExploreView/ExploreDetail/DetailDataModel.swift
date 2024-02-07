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
    var id: Int
    var dongAreaId: Int
    var userId: Int
    var detailAddress: String
    var name: String
    var info: String
    var latitude: Double
    var longitude: Double
    var image: [String]
    var stars: Float
    var likes: Int
    var guestbook : Int
}

struct StoreDetailDataModel: Codable {
    var check: Bool
    var information: StoreInformation
}

struct StoreInformation: Codable {
    var storeId: Int
    var userId: Int
    var detailAddress: String
    var name: String
    var info: String
    var latitude: Double
    var longitude: Double
    var image: [String]
    var stars: Float
    var type: StoreType
    var benefit: [String]
    var guestbookCount: Int
    var likeCount: Int
}

enum StoreType: String, Codable {
    case restaurant
    case cafe
}
