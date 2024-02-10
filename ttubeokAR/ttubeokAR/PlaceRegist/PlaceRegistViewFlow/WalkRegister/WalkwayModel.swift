//
//  WalkwayModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import Foundation
import SwiftUI

struct RequestWalwayRegistModel {
    var name: String?
    var address: String?
    var detailAddress: String?
    var info: String?
    var latitude: Double?
    var longitude: Double?
    var image: [String]?
    var starts: Float
}

struct ResponseWalwayRegistModel: Codable {
    var check: Bool
    var information: WalwayRegistInfor
}

struct WalwayRegistInfor: Codable {
    var name: String?
    var address: String?
    var detailAddress: String?
    var info: String?
    var latitude: Double?
    var longitude: Double?
    var image: [String]?
}
