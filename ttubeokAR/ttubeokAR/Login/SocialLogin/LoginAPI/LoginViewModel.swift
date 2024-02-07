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
    //MARK: - Property
    private let provider = MoyaProvider<ServerAPI>()
    private let keyChainManger = KeyChainManager.stadard
    @Published var savedLoginToken = false
    
    //MARK: - LoginFunction
    
    /// 카카오 로그인 성공 후, 뚜벅 서버로 토큰 전달 후 refresh 토큰 받기
    /// - Parameter token: 카카오톡 로그인 성공해서 받은 토큰
    public func KakaoSendToken(token: String) {
        provider.request(.sendKakaoToken(token: token)) { result in
            switch result {
            case .success(let response):
                do {
                    let serverResponse = try JSONDecoder().decode(LoginServerResponse.self, from: response.data)
                    print("서버 응답 : \(serverResponse)") // 추후 삭제 할 것!
                    if let accessToken = serverResponse.accessToken,
                       let refreshToken = serverResponse.refreshToken {
                        self.saveSession(accessToken: accessToken, refreshToken: refreshToken)
                    }
                } catch {
                    print("응답 실패: \(error)") // 추후 삭제 할 것!
                }
            case .failure(let error):
                print("서버 전송 실패 : \(error.localizedDescription)") // 추후 삭제 할 것!
            }
        }
    }
    
    /// 애플 로그인 성공 후, 뚜벅 서버로 유저 데이터 전달 후 refresh 토큰 받기
    /// - Parameter userData: 애플 로그인 성공 후 전달 받은 유저 데이터
    public func sendAppleToken(userData: AppleUserData) {
        provider.request(.sendAppleLoginInfo(userData: userData)) { result in
            switch result {
            case .success(let response):
                do {
                    let serverResponse = try JSONDecoder().decode(LoginServerResponse.self, from: response.data)
                    print("애플 로그인 서버 응답: \(serverResponse)")
                    if let accessToken = serverResponse.accessToken,
                       let refreshToken = serverResponse.refreshToken {
                        self.saveSession(accessToken: accessToken, refreshToken: refreshToken)
                    }
                } catch {
                    print("응답 실패 : \(error.localizedDescription)")
                }
            case.failure(let error):
                print("애플 로그인 서버 전송 실패: \(error.localizedDescription)")
            }
        }
    }
    
    /// 토큰 저장되어 있는지 체크하기
    public func checkLoginStatus() {
        if let session = keyChainManger.loadSession(for: "userSession"),
           let nickname = session.nickname, !nickname.isEmpty {
            savedLoginToken = true
            print(session)
        } else {
            savedLoginToken = false
        }
    }
    
    private func saveSession(accessToken: String, refreshToken: String) {
        let session = UserSession(accessToken: accessToken, refreshToken: refreshToken, nickname: nil)
        let saved = keyChainManger.saveSession(session, for: "userSession")
        if !saved {
            print("세션 저장 실패")
        }
    }
}
