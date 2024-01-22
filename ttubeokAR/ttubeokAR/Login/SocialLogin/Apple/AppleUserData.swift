//
//  AppleUserData.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import Foundation


//TODO: - 유저 데이터 및 토큰 정보 전달할 수 있도록 모델 수정
struct AppleUserData: Codable {
    var userIdentifier: String
    var firstName: String
    var lastName: String
    var email: String
    var authorizationCode: String?
    var identityToken: String?
}
