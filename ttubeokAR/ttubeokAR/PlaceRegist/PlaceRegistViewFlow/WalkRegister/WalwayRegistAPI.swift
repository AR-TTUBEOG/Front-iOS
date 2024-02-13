//
//  WalwayRegistAPI.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation
import Moya

enum WalkwayRegistService {
    case sendWalwayInfo(RequestWalwayRegistModel, token: String)
}

extension WalkwayRegistService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .sendWalwayInfo:
            return "/api/v1/spot"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendWalwayInfo:
            return .post
        }
    }
    
    //TODO: - 스웨거랑 모델 데이터 다름 (Address부분 다르다)
    var task: Task {
        switch self {
        case .sendWalwayInfo(let parameters, _):
            let param: [String: Any] = [
                "name": parameters.name ?? "",
                "address": parameters.address ?? "",
                "detailAddress": parameters.detailAddress ?? "",
                "info": parameters.info ?? "",
                "latitude": parameters.latitude ?? 0.0,
                "longitude": parameters.longitude ?? 0.0,
                "image": parameters.image ?? []
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendWalwayInfo(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
