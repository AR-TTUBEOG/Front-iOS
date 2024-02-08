//
//  CommentAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/9/24.
//

import Foundation
import Moya

enum CommentAPITarget {
    case CreateComment(content: String, latitude: Double, longitude: Double)
}

extension CommentAPITarget : TargetType{
    var baseURL: URL {
            return URL(string: "ttubeog.kro.kr")!
        }
        
        
        var path: String {
            switch self {
            case .CreateComment:
                return "/api/v1/comment"
            }
        }
        
        var method: Moya.Method {
            switch self {
            case .CreateComment:
                return .post
            }
        }
        
        var task: Moya.Task {
            switch self {
            case let .CreateComment(content, latitude,longitude):
                return .requestParameters(parameters: ["content": content,"latitude": latitude, "longitude": longitude], encoding: JSONEncoding.default)
            }
        }
        
        var headers: [String : String]? {
            return [
                "Content-Type": "application/json"
            ]
        }
    }

