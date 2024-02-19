//
//  CouponAPITarget.swift
//  ttubeokAR
//
//  Created by Subeen on 2/12/24.
//

// [GET] [/api/benefit]

import Foundation
import Moya

enum BenefitService {
    case exploreCoupon(token: String)
    case patchCoupon(benefitId: Int, token: String)
}

extension BenefitService: TargetType {
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .exploreCoupon:
            return "/api/benefit"
        case .patchCoupon(let benefitId, _):
            return "/api/benefit/\(benefitId)/use"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .exploreCoupon:
            return .get
        case .patchCoupon:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .exploreCoupon:
            return .requestPlain
        case .patchCoupon(let benefitId, _):
            let parameters: [String : Any] = [
                "benefitId": benefitId
            ]
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .exploreCoupon(let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .patchCoupon(let token, _):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
