//
//  NicknameRedundancyService.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation
import Moya

enum NicknameRedundancyService {
    case checkNicname(String)
}

extension NicknameRedundancyService: TargetType {
    var baseURL: URL {
        return URL(string: "http://api.com")!
    }
    
    var path: String {
        switch self {
        case .checkNicname:
            return "/check-name"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .checkNicname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return ["Content-type": "application/json"]
        }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
