//
//  BookMarkAPI.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/6/24.
//

import Foundation
import Moya

enum BookMarkAPI {
    case bookmarkSpace(storeId: Int)
}

extension BookMarkAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://BookMarkAPI")!
    }

    var path: String {
        switch self {
        case .bookmarkSpace:
            return "/spaces/bookmark"
        }
    }

    var method: Moya.Method {
        switch self {
        case .bookmarkSpace:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .bookmarkSpace(spaceId):
            return .requestParameters(parameters: ["storeId": storeId], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
