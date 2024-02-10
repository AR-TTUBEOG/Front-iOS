//
//  ExploreAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/2/24.
//

import Foundation
import Moya

enum ExploreAPITarget {
    case createBookMark(id : Int, memberId: Int, content: String, star: Float,image : String)
    case likeWalkWay(spotId: Int)
    case likeStoreData(storeId: Int)
}

//TODO: - 실제 api로 수정하기

extension ExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String {
        switch self {
        case .createBookMark:
            return "/bookMark/create"
        case .likeWalkWay(let spotId):
            return "/api/spot/\(spotId)/likes"
        case .likeStoreData(let storeId):
            return "/api/store/\(storeId)/likes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createBookMark:
            return .post
        case .likeWalkWay:
            return .post
        case .likeStoreData:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .createBookMark(id, memberId, content, star, image):
            return .requestParameters(parameters: ["id":id,"memberId":memberId,"content":content,"star":star,"image":image], encoding: JSONEncoding.default)
        case .likeWalkWay(let spotId):
            return .requestParameters(parameters: ["spotId": spotId], encoding: JSONEncoding.default)
        case .likeStoreData(let storeId):
            return .requestParameters(parameters: ["storeId": storeId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    
}


