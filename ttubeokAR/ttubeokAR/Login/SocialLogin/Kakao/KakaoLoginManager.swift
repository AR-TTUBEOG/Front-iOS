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
    
    //MARK: - Property
    private let loginViewModel = LoginViewModel()
    @Published var isLoggedIn = false
    
    //MARK: - KakaoLoginManagerFunction
    /// 카카오톡 로그인 -> 앱 또는 웹으로 로그인 진행
    /// - Parameter completion: 로그인 결과에 대한 토큰 또는 에러처리
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
    
    /// 성공적인 로그인 토쿤을 포함한다. 또는 로그인 중 오류 발생 시 오류 처리
    /// - Parameters:
    ///   - oauthToken: 로그인 성공 시 제공되는 토큰
    ///   - error: 로그인 처리 중 오류 발생 시 반환 한다.
    ///   - completion: 성공 시 토큰 반환, 오류 시 오류를 반환
    private func handleLoginResponse(oauthToken: OAuthToken?, error: Error?, completion: @escaping (Result<OAuthToken, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let oauthToken = oauthToken {
            print("액세스 토큰값 : \(oauthToken.accessToken)")
            completion(.success(oauthToken))
        }
    }
    
    /// 로그인을 성공하여 반환 받은 토큰에 대해 뚜벅 서버로 전달
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
