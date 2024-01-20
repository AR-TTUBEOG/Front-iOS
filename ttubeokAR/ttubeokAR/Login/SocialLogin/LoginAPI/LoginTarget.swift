//
//  LoginTarget.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Moya
import Foundation

enum ServerAPI {
    case sendToken(token: String, authorizationToken: String)
}

extension ServerAPI: TargetType {
    var baseURL: URL { return URL(string: "https://loginServer")! }
    
    var path: String {
        switch self {
        case .sendToken:
            return "/auth/login/kakao"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendToken(let token, _):
            return .requestParameters(parameters: ["token": token], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendToken(_, let authorizationToken):
            return [
                "Authorization": authorizationToken,
                "Content-Type": "application/json"
            ]
        }
    }
}
