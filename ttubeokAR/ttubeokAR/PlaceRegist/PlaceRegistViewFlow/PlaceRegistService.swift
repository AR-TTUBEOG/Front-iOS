//
//  WalwayRegistAPI.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation
import Moya

enum PlaceRegistService {
    case sendWalwayInfo(RequestWalwayRegistModel, token: String)
    case sendStoreInfo(RequestMarketRegistModel, token: String)
}

extension PlaceRegistService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .sendWalwayInfo:
            return "/api/v1/spot"
        case .sendStoreInfo:
            return "/api/v1/store"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendWalwayInfo:
            return .post
        case .sendStoreInfo:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendWalwayInfo(let parameters, _):
            return .requestJSONEncodable(parameters)
        case .sendStoreInfo(let parameters, _):
            return .requestJSONEncodable(parameters)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendWalwayInfo(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .sendStoreInfo(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
