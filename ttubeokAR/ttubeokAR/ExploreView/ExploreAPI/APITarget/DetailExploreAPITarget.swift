//
//  DetailExploreAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/3/24.
//

import Foundation
import Moya

enum DetailExploreAPITarget {
    case fetchWalkWayDetail(spotId: Int, token: String)
    case fetchStoreDetail(storeId: Int, token: String)
    case fetchWalkWayImage(spotId: Int, token: String)
    case fetchStoreImage(storeId: Int, token: String)
}

extension DetailExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String{
        switch self {
        case .fetchWalkWayDetail(let spotId, _):
            return "/api/v1/spot/\(spotId)"
        case .fetchStoreDetail(let storeId, _):
            return "/api/v1/store/\(storeId)"
        case .fetchWalkWayImage(let spotId, _):
            return "/api/v1/image/spot/\(spotId)"
        case .fetchStoreImage(let storeId, _):
            return "/api/v1/image/store/\(storeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchWalkWayDetail:
            return .get
        case .fetchStoreDetail:
            return .get
        case .fetchWalkWayImage:
            return .get
        case .fetchStoreImage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWalkWayDetail:
            return .requestPlain
        case .fetchStoreDetail:
            return .requestPlain
        case .fetchWalkWayImage:
            return .requestPlain
        case .fetchStoreImage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchWalkWayDetail(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
                ]
        case .fetchStoreDetail(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
                ]
        case .fetchWalkWayImage(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
                ]
        case .fetchStoreImage(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
                ]
        }
    }
}
