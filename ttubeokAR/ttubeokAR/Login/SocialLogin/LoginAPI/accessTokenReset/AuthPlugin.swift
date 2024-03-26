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
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        if case .failure(let error) = result, error.response?.statusCode == 500 {
            refreshToken { [weak self] success in
                guard self != nil else { return }
                print("토큰 초기화 결과 : \(success)")
            }
        }
    }
    
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = KeyChainManager.standard.getRefreshToken(for: "userSession") else {
            completion(false)
            return
        }
        
        let target = MultiTarget(RefreshService.refreshToken(refreshToken: refreshToken))
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    print("** - 중간 리프레시 토큰 초기화 작업 수행 완료 - ")
                    let tokenResponse = try response.map(TokenResponse.self)
                    if var session = KeyChainManager.standard.loadSession(for: "userSession") {
                        session.accessToken = tokenResponse.information.accessToken ?? ""
                        if KeyChainManager.standard.saveSession(session, for: "userSession") {
                            print(" 토큰 초기화 저장 완료")
                        }
                        completion(true)
                    } else {
                        completion(false)
                        print("** - 중간 리프레시 토큰 초기화 작업 중단 (토큰 존재 x) - ")
                    }
                } catch {
                    completion(false)
                    print("** - 중간 리프레시 토큰 초기화 작업 해독 오류 - ")
                }
                
            case .failure:
                completion(false)
                print("** - 중간 리프레시 토큰 초기화 작업 연결 오류 - ")
            }
        }
    }
}
