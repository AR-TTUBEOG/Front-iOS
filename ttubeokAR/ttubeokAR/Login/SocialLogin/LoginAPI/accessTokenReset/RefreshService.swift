//
//  RefreshService.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/16/24.
//

import Foundation
import Moya

enum RefreshService {
    case refreshToken(refreshToken: String)
}

extension RefreshService: TargetType {
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/api/v1/member/login/reissue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .refreshToken:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .refreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .refreshToken(let refreshToken):
            return ["Authorization": "Bearer \(refreshToken)"]
        }
    }
}
