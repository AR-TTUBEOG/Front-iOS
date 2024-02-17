//
//  SearchAPITarget.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/8/24.
//

import Foundation
import Moya

enum SearchAPITarget {
    case searchAll(page: Int, size: Int, token: String)
    case searchLatest(page: Int, size: Int, token: String)
    case searchDistance(page: Int, size: Int, token: String)
    case searchRecommend(page: Int, size: Int, token: String)
}

extension SearchAPITarget: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String {
        switch self {
        case .searchAll:
            return "/api/place"
        case .searchLatest:
            return "/api/place/latest"
        case .searchDistance:
            return "/api/place/nearby"
        case .searchRecommend:
            return "/api/place/recommended"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchAll:
            return .get
        case .searchLatest:
            return .get
        case .searchDistance:
            return .get
        case .searchRecommend:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchAll(let page, let size, _):
            return .requestParameters(parameters: ["page": page, "size:": size], encoding: URLEncoding.queryString)
        case .searchLatest(let page, let size, _):
            return .requestParameters(parameters: ["page": page, "size:": size], encoding: URLEncoding.queryString)
        case .searchDistance(let page, let size, _):
            return .requestParameters(parameters: ["page": page, "size:": size], encoding: URLEncoding.queryString)
        case .searchRecommend(let page, let size, _):
            return .requestParameters(parameters: ["page": page, "size:": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let token: String
        switch self {
        case .searchAll(_, _, let tokenValue), .searchLatest(_, _, let tokenValue), .searchDistance(_, _, let tokenValue), .searchRecommend(_, _, let tokenValue):
            token = tokenValue
        }
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
}
