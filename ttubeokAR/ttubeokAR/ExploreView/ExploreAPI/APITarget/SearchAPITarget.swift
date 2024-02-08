//
//  SearchAPITarget.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/8/24.
//

import Foundation
import Moya

enum SearchAPITarget {
    case searchAll(page: Int)
    case searchLatest(page: Int)
    case searchDistance(page: Int)
    case searchRecommend(page: Int)
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
        case .searchAll(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case .searchLatest(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case .searchDistance(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case .searchRecommend(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
