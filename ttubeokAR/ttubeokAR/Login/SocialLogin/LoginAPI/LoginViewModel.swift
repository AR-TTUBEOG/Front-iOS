//
//  LoginViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/21/24.
//

import Foundation
import Moya
import SwiftUI

class LoginViewModel: ObservableObject {
    private let kakaoLoginManager = KakaoLoginManager()
    private let provider = MoyaProvider<ServerAPI>()
    private let authorizationToken = "authorization_token"
    @Published var isLoggedIn = false
    
    func loginAndSendToken() {
        kakaoLoginManager.login{ [weak self] result in
            switch result {
            case .success(let oauthToken):
                self?.sendToken(token: oauthToken.accessToken)
                self?.isLoggedIn = true
            case .failure(let error):
                print("로그인 실패: \(error.localizedDescription)")
                self?.isLoggedIn = false
            }
        }
    }
    
    private func sendToken(token: String) {
        provider.request(.sendToken(token: token, authorizationToken: authorizationToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let serverResponse = try JSONDecoder().decode(LoginServerResponse.self, from: response.data)
                    print("서버 응답 : \(serverResponse)")
                } catch {
                    print("응답 실패: \(error)")
                }
            case .failure(let error):
                print("서버 전송 실패 : \(error.localizedDescription)")
            }
        }
    }
}
