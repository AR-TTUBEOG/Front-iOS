//
//  KakaoLoginManager.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/20/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginManager: ObservableObject {
    private let loginViewModel = LoginViewModel()
    @Published var isLoggedIn = false
    
    private func login(completion: @escaping (Result<OAuthToken, Error>) -> Void) {
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
    
    
    private func handleLoginResponse(oauthToken: OAuthToken?, error: Error?, completion: @escaping (Result<OAuthToken, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let oauthToken = oauthToken {
            print("액세스 토큰값 : \(oauthToken.accessToken)")
            completion(.success(oauthToken))
        }
    }
    
    public func loginAndSendToken() {
        self.login{ [weak self] result in
            switch result {
            case .success(let oauthToken):
                self?.loginViewModel.KakaoSendToken(token: oauthToken.accessToken)
                self?.isLoggedIn = true
            case .failure(let error):
                print("로그인 실패: \(error.localizedDescription)")
                self?.isLoggedIn = false
            }
        }
    }
}
