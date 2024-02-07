//
//  UserSession.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import Foundation


struct UserSession: Codable {
    var accessToken: String
    var refreshToken: String
    var nickname: String?
}
