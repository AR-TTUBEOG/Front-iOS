//
//  BookMarkMakeAPI.swift
//  ttubeokAR
//
//  Created by 정의찬 on 3/25/24.
//

import Foundation
import Moya

enum BookMarkAPI {
    case createBookMark(data: BookMarkInputData, token: String)
}

extension BookMarkAPI: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String {
        switch self {
        case .createBookMark:
            return "/api/v1/guestbook"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createBookMark:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createBookMark(let data, _):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createBookMark(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
