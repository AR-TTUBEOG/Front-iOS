//
//  WalkwayModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import Foundation
import SwiftUI

struct RequestWalwayRegistModel: Codable {
    var name: String?
    var dongAreaId: String?
    var detailAddress: String?
    var info: String?
    var latitude: Double?
    var longitude: Double?
}

struct ResponseWalkwayRegistModel: Codable {
    var check: Bool
    var information: WalwayRegistInfor
}

struct WalwayRegistInfor: Codable {
    var id: Int?
    var name: String?
    var dongAreaId: String?
    var detailAddress: String?
    var memberId: Int?
    var info: String?
    var latitude: Double?
    var longitude: Double?
    var stars: Float?
}

struct WalkwayRegistImage {
    var check: Bool
    var information: [WalkwayRegistImageInfo]
}

struct WalkwayRegistImageInfo: Codable {
    var id: Int
    var uuid: String
    var image: String
    var imageType: String
    var placId: Int
}
