//
//  LoginTarget.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Moya
import Foundation

enum ServerAPI {
    case sendToken(token: String)
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
        case .sendToken(let token):
            return .requestParameters(parameters: ["accessToken": token], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
