//
//  ResetTokenModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/16/24.
//

import Foundation

struct TokenResponse: Decodable {
    var accessToken: String?
    var refreshToken: String?
    var isRegistered: Bool?
}
