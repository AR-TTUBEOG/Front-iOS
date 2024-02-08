//
//  RouteService.swift
//  ttubeokAR
//
//  Created by Subeen on 1/24/24.
//

import Foundation
import Moya

// 에러 정의
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

enum RouteService {
    case getRoute(origin_lon: Double, origin_lat: Double, dest_lon: Double, dest_lat: Double)
}

extension RouteService: TargetType {
    var baseURL: URL {
        return URL(string: RouteAPI.baseUrl)!
    }
    
    var path: String {
            switch self {
            case .getRoute(let origin_lon, let origin_lat, let dest_lon, let dest_lat):
                return "/route/v1/foot/\(origin_lon),\(origin_lat);\(dest_lon),\(dest_lat)"
            }
        }
    
    var method: Moya.Method {
        switch self {
        case .getRoute:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getRoute(let origin_lon, let origin_lat, let dest_lon, let dest_lat):
//            let parameters : [String : Any] = [
//                "origin_lon" : origin_lon,
//                "origin_lat" : origin_lat,
//                "dest_lon" : dest_lon,
//                "dest_lat" : dest_lat
//            ]
            let paramters: [String : Any] = [
                "steps": "true", "geometries": "geojson"
            ]
            
            return .requestParameters(parameters: paramters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

}

