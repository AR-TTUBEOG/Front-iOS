//
//  GuestBookAPI.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/6/24.
//

import Foundation
import Moya

enum GuestBookAPI {
    case createBook(name: String, message: String)
}

extension GuestBookAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://GuestBookAPI")!
    }

    var path: String {
        switch self {
        case .createBook:
            return "/guestbook/create"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createBook:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .createBook(name, message):
            return .requestParameters(parameters: ["name": name, "message": message], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

}
