//
//  BookMarkDataModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/6/24.
//

import Foundation

// MARK: - 방명록 데이터 저장 모델
struct BookMarkInputData: Codable {
    var guestBookType: SpaceType
    var spotId: Int?
    var storeId: Int?
    var content: String?
    var star: Float?
}

enum SpaceType: String, Codable {
    case SPOT
    case STORE
}

// MARK: - API 데이터 받아오기

struct BookMarkDataModel: Codable {
    var check: Bool
    var information: BookMarkData
}

struct BookMarkData: Codable {
    var id: Int
    var memberId: Int
    var guestBookType: SpaceType
    var spotId: Int?
    var storeId: Int?
    var content: String?
    var star: Int
}
