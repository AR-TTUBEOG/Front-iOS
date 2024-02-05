//
//  ExploreAPITarget.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/2/24.
//

import Foundation
import Moya

enum ExploreAPITarget {
    case fetchExploreData
}

extension ExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "https://Explore")! }
    
    var path: String{
        switch self {
        case .fetchExploreData:
              return "/explore/data"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchExploreData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchExploreData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
             ]
    }
    
  
}


