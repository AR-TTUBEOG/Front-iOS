//
//  GuestBookModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation


struct GuestBookModel: Codable, Hashable {
    var check: Bool
    var information: [GuestBookModelInfor]
}

struct GuestBookModelInfor: Codable, Hashable {
    var id: Int
    var memberId: Int
    var guestBookType: String
    var spotId: Int
    var storeId: Int
    var content: String
    var star : Int
}

struct MemeberCheck: Codable {
    var id: Int
    var name: String
    var platform: String
    var isChanged: Bool
}
