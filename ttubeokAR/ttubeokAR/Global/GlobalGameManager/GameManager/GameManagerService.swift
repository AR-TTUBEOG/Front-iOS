//
//  GameManagerService.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/15/24.
//

import Foundation
import Moya

enum GameManagerService {
    case roulette(benefitRequest: RouletteModel, token: String)
    case basketBall(benefitRequest: BasketBallModel, token: String)
    case gift(benefitRequest: GifttModel, token: String)
}

extension GameManagerService: TargetType {
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .roulette:
            return "/api/v1/game/roulette"
        case .basketBall:
            return "/api/v1/game/basketball"
        case .gift:
            return "/api/v1/game/gift"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .roulette:
            return .post
        case .basketBall:
            return .post
        case .gift:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .roulette(let benefitRequest, _):
            return .requestJSONEncodable(benefitRequest)
        case .basketBall(let benefitRequest, _):
            return .requestJSONEncodable(benefitRequest)
        case .gift(let benefitRequest, _):
            return .requestJSONEncodable(benefitRequest)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .roulette(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            
        case .basketBall(_, let token):
            return [
                "Content-Type": "application/json;charset=UTF-8",
                "accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
            
        case .gift(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
