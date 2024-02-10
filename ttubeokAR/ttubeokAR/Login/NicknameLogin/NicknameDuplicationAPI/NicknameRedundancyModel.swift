//
//  NicknameDuplication.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation

struct NicknameRedundancyModel: Codable {
    var check: Bool
    var information: NicnameInformation
}

struct NicnameInformation: Codable {
    var id: Int
    var name: String
    var platform: String
    var isUsed: Bool
}
