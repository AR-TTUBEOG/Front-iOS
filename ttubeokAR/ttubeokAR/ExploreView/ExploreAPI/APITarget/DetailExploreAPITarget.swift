//
//  DetailExploreAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/3/24.
//

import Foundation
import Moya

enum DetailExploreAPITarget {
    case fetchExploreDetail(storeId : Int)
}

extension DetailExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "https://Explore")! }
    
    var path: String{
        switch self {
        case .fetchExploreDetail(let storeId):
            return "/explore/detail/\(storeId)"
        }

    }
    
    var method: Moya.Method {
        switch self {
        case .fetchExploreDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchExploreDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
             ]
    }
    
  
}
