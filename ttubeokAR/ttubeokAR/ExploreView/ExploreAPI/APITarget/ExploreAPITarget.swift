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
    case createBookMark(id : Int, memberId: Int, content: String, star: Float,image : String)
}

//TODO: - 실제 api로 수정하기

extension ExploreAPITarget: TargetType {
    var baseURL: URL { return URL(string: "https://Explore")! }
    
    var path: String{
        switch self {
        case .fetchExploreData:
              return "/explore/data"
        case .createBookMark:
            return "/bookMark/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchExploreData:
            return .get
        case .createBookMark:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchExploreData:
            return .requestPlain
        case let .createBookMark(id, memberId, content, star, image):
            return .requestParameters(parameters: ["id":id,"memberId":memberId,"content":content,"star":star,"image":image], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
             ]
    }
    
  
}


