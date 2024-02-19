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
    case likeWalkWay(spotId: Int, token: String)
    case likeStoreData(storeId: Int, token: String)
    case getWalkImage(spotId: Int, token: String)
    case getStoreImage(spotId: Int, token: String)
}

//TODO: - 실제 api로 수정하기

extension ExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String {
        switch self {
        case .createBookMark:
            return "/bookMark/create"
        case .likeWalkWay(let spotId, _):
            return "/api/v1/spot/\(spotId)/likes"
        case .likeStoreData(let storeId, _):
            return "/api/v1/store/\(storeId)/likes"
        case .getWalkImage(let spotId, _):
            return "/api/v1/image/\(spotId)"
        case .getStoreImage(let storeId, _):
            return "/api/v1/image/\(storeId)"
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
        case .getWalkImage:
            return .get
        case .getStoreImage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .createBookMark(id, memberId, content, star, image):
            return .requestParameters(parameters: ["id":id,"memberId":memberId,"content":content,"star":star,"image":image], encoding: JSONEncoding.default)
        case .likeWalkWay(let spotId, _):
            return .requestParameters(parameters: ["spotId": spotId], encoding: JSONEncoding.default)
        case .likeStoreData(let storeId, _):
            return .requestParameters(parameters: ["storeId": storeId], encoding: JSONEncoding.default)
        case .getWalkImage(let spotId, _):
            return .requestParameters(parameters: ["spotId": spotId], encoding: JSONEncoding.default)
        case .getStoreImage(let storeId, _):
            return .requestParameters(parameters: ["spotId": storeId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createBookMark(let id, let memberId, let content, let star, let image):
            return [
                "Content-Type": "application/json",
            ]
            
        case .likeWalkWay(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            
        case .likeStoreData(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .getWalkImage(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .getStoreImage(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
        
    }
    
    
}


