//
//  DetailExploreAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/3/24.
//

import Foundation
import Moya

enum DetailExploreAPITarget {
    case fetchWalkWayDetail(spotId: Int)
    case fetchStoreDetail(storeId: Int)
}

extension DetailExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String{
        switch self {
        case .fetchWalkWayDetail(let spotId):
            return "/api/spot/\(spotId)"
        case .fetchStoreDetail(let storeId):
            return "/api/store/\(storeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWalkWayDetail:
            return .get
        case .fetchStoreDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWalkWayDetail:
            return .requestPlain
        case .fetchStoreDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
            ]
    }
}
