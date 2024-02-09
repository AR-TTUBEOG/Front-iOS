//
//  NaverReverseGeocodingAPI.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/9/24.
//

import Foundation
import Moya

enum NaverReverseGeocodingAPI {
    case reverseGeocode(latitude: String, logitude: String)
}

extension NaverReverseGeocodingAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode")!
    }
    
    var path: String {
        switch self {
        case .reverseGeocode:
            return "/v2/gc"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .reverseGeocode(let latitude, let longitude):
            let params: [String: Any] = [
                "coords": "\(longitude),\(latitude)",
                "orders": "roadaddr",
                "output": "json"
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "X-NCP-APIGW-API-KEY-ID":Bundle.main.nmfClientId,
            "X-NCP-APIGW-API-KEY":Bundle.main.nmfClientSecret
            ]
    }
}
