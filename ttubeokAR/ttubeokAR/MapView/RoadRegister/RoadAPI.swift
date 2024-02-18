//
//  RoadAPI.swift
//  ttubeokAR
//
//  Created by Subeen on 2/18/24.
//

import Foundation
import Moya

enum RoadService {
    case postRoad(RequestRoadModel, token: String)
    case getStoreRoad(storeId: Int, pageNum: Int, token: String)
    case getSpotRoad(spotId: Int, pageNum: Int, token: String)
    case deleteRoad(roadId: Int, token: String)
}

extension RoadService: TargetType {
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .postRoad:
            return "api/v1/road"
        case .getStoreRoad(let storeId, let pageNum, _):
            return "api/v1"
        case .getSpotRoad(let spotId, let pageNum, _):
            return "api/v1/\(spotId)/\(pageNum)"
        case .deleteRoad(let roadId, _):
            return "api/v1/\(roadId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postRoad:
            return .post
        case .getSpotRoad:
            return .get
        case .getStoreRoad:
            return .get
        case .deleteRoad:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postRoad:
            return .requestPlain
        case .getStoreRoad(let storeId, let pageNum, _):
            let parameters: [String : Any] = [
                "storeId": storeId,
                "pageNum": pageNum,
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getSpotRoad(let spotId, let pageNum, _):
            let parameters: [String: Any] = [
                "spotId": spotId,
                "pageNum": pageNum
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .deleteRoad(let roadId, _):
            let parameters: [String: Any] = [
                "roadId": roadId
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postRoad(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .getSpotRoad(_, _, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            
        case .getStoreRoad(_, _, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            
        case .deleteRoad(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
