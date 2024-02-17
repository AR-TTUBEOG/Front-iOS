//
//  AuthPlugin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/16/24.
//

import Foundation
import Moya

final class AuthPlugin: PluginType {
    
    var provider: MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
    
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let accessToken = KeyChainManager.stadard.getAccessToken(for: "userSession") {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if case .failure(let error) = result, error.response?.statusCode == 401 {
            refreshToken { [weak self] success in
                guard self != nil else { return }
            }
        }
    }
    
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = KeyChainManager.stadard.getRefreshToken(for: "userSession") else {
            completion(false)
            return
        }
        
        let target = MultiTarget(RefreshService.refreshToken(refreshToken: refreshToken))
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let tokenResponse = try response.map(TokenResponse.self)
                    if var session = KeyChainManager.stadard.loadSession(for: "userSession") {
                        session.accessToken = tokenResponse.accessToken ?? ""
                        if KeyChainManager.stadard.saveSession(session, for: "userSession") {
                            completion(true)
                        }
                    }
                    completion(false)
                } catch {
                    completion(false)
                }
            case .failure:
                completion(false)
            }
        }
    }
}
