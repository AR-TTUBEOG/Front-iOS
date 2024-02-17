//
//  LoginModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation

/**
 로그인 리퀘스를 통해 전달받을 데이터 모델
 */

struct LoginServerResponse: Codable {
    var accessToken: String?
    var refreshToken: String?
    var isRegistered: Bool?
}
