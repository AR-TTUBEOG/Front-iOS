//
//  NicknameDuplication.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation

struct NicknameRedundancyModel: Codable {
    var check: Bool
    var information: String
}

struct NicknameInformation: Codable {
    var id: Int?
    var nickname: String?
    var nicknameChanged: Bool?
}
