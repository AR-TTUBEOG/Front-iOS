//
//  ResetTokenModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/16/24.
//

import Foundation

struct TokenResponse: Codable {
    var check: Bool
    var information: TokenResponseInfo
}

struct TokenResponseInfo: Codable {
    var accessToken: String?
    var refreshToken: String?
    var isRegistered: Bool?
}
