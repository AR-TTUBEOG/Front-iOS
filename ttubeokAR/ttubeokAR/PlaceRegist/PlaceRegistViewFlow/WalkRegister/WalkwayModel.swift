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
    var image: [String]?
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
    var image: [String]?
    var stars: Double?
}

