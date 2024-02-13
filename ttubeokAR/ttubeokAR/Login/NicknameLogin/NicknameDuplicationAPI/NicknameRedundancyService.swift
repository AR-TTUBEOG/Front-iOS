//
//  NicknameRedundancyService.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation
import Moya

/**
 닉네임 중복 검사 요청 API
 */

enum NicknameRedundancyService {
    case checkNickname(String, token: String)
}

//TODO: - API 설정하기
extension NicknameRedundancyService: TargetType {
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .checkNickname:
            return "/api/v1/member/nickname"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    //TODO: - 추후 파라미터로 닉네임과 토큰 같이 전달해야할 수 있음!
    var task: Task {
        switch self {
        case .checkNickname(let nickname, _):
            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .checkNickname(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
