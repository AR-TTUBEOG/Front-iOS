//
//  MarketModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/5/24.
//

import Foundation
import SwiftUI


struct MarketModel {
    var images: [UIImage] = []
}


//MARK: - 매장 등록 모델

struct RequestMarketRegistModel: Codable {
    var name: String?
    var info: String?
    var dongAreaId: String?
    var detailAddress: String?
    var latitude: Double?
    var longitude: Double?
    var image: [String]?
    var type: String?
}


struct ResponseMarketRegistModel: Codable {
    var check: Bool
    var information: MarketRegistInfor
}

struct MarketRegistInfor: Codable {
    var storeId: Int?
    var memberId: Int?
    var name: String?
    var info: String?
    var dongAreaId: String?
    var detailAddress: String?
    var latitude: Double?
    var longitude: Double?
    var image: [String]?
    var starts: Int?
    var type: String?
}
