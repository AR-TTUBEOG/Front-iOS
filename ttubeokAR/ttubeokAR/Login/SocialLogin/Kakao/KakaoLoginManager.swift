//
//  KakaoLoginManager.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/20/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginManager {
    
    func login(completion: @escaping (Result<User, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.handleLoginResponse(oauthToken: oauthToken, error: error, completion: completion)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.handleLoginResponse(oauthToken: oauthToken, error: error, completion: completion)
            }
        }
    }

    
    private func handleLoginResponse(oauthToken: OAuthToken?, error: Error?, completion: @escaping (Result<User, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let oauthToken = oauthToken {
            UserApi.shared.me { (user, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let user = user {
                    completion(.success(user))
                }
            }
        }
    }
}
