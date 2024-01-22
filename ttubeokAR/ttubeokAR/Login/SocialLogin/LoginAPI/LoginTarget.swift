//
//  LoginTarget.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Moya
import Foundation

/// 카카오톡, 애플 API를 나눠 사
/**
 sendToken : 카카오로 토큰 전달
 sendAppleLoginInfo : 애플 로그인 정보 전달
 */

//TODO: - 애플 로그인 시 유저데이터 토큰 전환하도록 바꾸기
enum ServerAPI {
    case sendToken(token: String)
    case sendAppleLoginInfo(userData: AppleUserData)
}

extension ServerAPI: TargetType {
    var baseURL: URL { return URL(string: "https://loginServer")! }
    
    var path: String {
        switch self {
        case .sendToken:
            return "/auth/login/kakao"
        case.sendAppleLoginInfo:
            return "/auth/login/apple"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendToken:
            return .post
        case.sendAppleLoginInfo:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendToken(let token):
            return .requestParameters(parameters: ["accessToken": token], encoding: JSONEncoding.default)
        case.sendAppleLoginInfo(let userData):
            let parameters: [String: Any] = [
                "userIdentifier": userData.userIdentifier ?? "",
                "fullName": userData.fullName ?? "",
                "email": userData.email ?? ""
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
