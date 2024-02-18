//
//  PlaceAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/18/24.
//

import Foundation
import Moya

enum PlaceAPITarget {
    case RegisteredPlace(token: String)
}

extension PlaceAPITarget : TargetType{
    var baseURL: URL {
            return URL(string: "http://ttubeog.kro.kr:8080/")!
        }
        
        
        var path: String {
            switch self {
            case .RegisteredPlace:
                return "/api/v1/comment"
            }
        }
        
        var method: Moya.Method {
            switch self {
            case .RegisteredPlace:
                return .get
            }
        }
        
        var task: Moya.Task {
            switch self {
            case .RegisteredPlace:
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            switch self {
            case .RegisteredPlace(let token):
                return [
                    "Content-Type": "application/json",
                    "Authorization" : "Bearer \(token)"
                ]
            }
            
            
        }
    }
