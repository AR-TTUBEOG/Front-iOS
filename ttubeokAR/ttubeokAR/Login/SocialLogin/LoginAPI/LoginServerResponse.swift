//
//  LoginModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation

struct LoginServerResponse: Codable {
    var check: Bool
    var information: Information?
}

struct Information: Codable {
    var accessToken: String
    var refreshToken: String
    var early: Bool
}
