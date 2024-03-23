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
    private let authPlugin: AuthPlugin
    private let provider: MoyaProvider<ServerAPI>
    private let keyChainManger = KeyChainManager.standard
    var loginRegist: Bool = false
    @Published var savedLoginToken = false
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<ServerAPI>(plugins: [authPlugin])
    }
    
    //MARK: - LoginFunction
    
    /// 카카오 로그인 성공 후, 뚜벅 서버로 토큰 전달 후 refresh 토큰 받기
    /// - Parameter token: 카카오톡 로그인 성공해서 받은 토큰
    public func KakaoSendToken(token: String) {
        provider.request(.sendKakaoToken(token: token)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let serverResponse = try JSONDecoder().decode(LoginServerResponse.self, from: response.data)
                    print("서버 응답 : \(serverResponse)")
                    if let accessToken = serverResponse.accessToken,
                       let refreshToken = serverResponse.refreshToken,
                       let isRegist = serverResponse.isRegistered {
                        self?.keyChainManger.firstAccessSaveSession(accessToken: accessToken, refreshToken: refreshToken)
                        self?.loginRegist = isRegist
                        print("2-0-1: 카카오톡 관련 정보 저장 완료")
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
        provider.request(.sendAppleLoginInfo(userData: userData)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let serverResponse = try JSONDecoder().decode(LoginServerResponse.self, from: response.data)
                    print("4. 애플 로그인 서버 응답: \(serverResponse)")
                    
                    if let accessToken = serverResponse.accessToken,
                       let refreshToken = serverResponse.refreshToken,
                        let isRegist = serverResponse.isRegistered {
                        self?.keyChainManger.firstAccessSaveSession(accessToken: accessToken, refreshToken: refreshToken)
                        self?.loginRegist = isRegist
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
    public func checkLoginStatus(completion: @escaping (Bool) -> Void) {
        print("2.토큰 저장 체크")
        if let session = keyChainManger.loadSession(for: "userSession"),
           let nickname = session.nickname, !nickname.isEmpty {
            print("2-0: 현재 사용자 정보 : \(session)")
            refreshToken { [weak self] success in
                if success {
                    print("2-1. 액세스 토큰 초기화 완료 : \(success)")
                    self?.savedLoginToken = success
                    completion(success)
                } else {
                    print("2-1. 액세스 토큰 초기화 오류 : \(success)")
                    completion(false)
                }
            }
        } else {
            print("2-2. 닉네임 없음")
            completion(false)
        }
    }
    
    //MARK: -  Token Initial
    
    /// 로그인 시 리프레시 토큰 갱신
    /// - Parameter completion: 리프레쉬 토큰 초기화를 통해 재발급한다.
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = keyChainManger.getRefreshToken(for: "userSession") else {
            completion(false)
            return
        }
        
        let target = MultiTarget(RefreshService.refreshToken(refreshToken: refreshToken))
        authPlugin.provider.request(target) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: response.data)
                    print("새로 받아온 토큰 : \(tokenResponse)")
                    self?.keyChainManger.initialRefreshSaveToken(accessToken: tokenResponse.information.accessToken ?? "",
                                                           refreshToken: tokenResponse.information.refreshToken ?? "", for: "userSession")
                    completion(true)
                    
                } catch {
                    completion(false)
                    print(error)
                }
            case .failure:
                print("토큰 초기화 에러")
                completion(false)
                
            }
        }
    }
    
    
}
