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
    private let provider = MoyaProvider<ServerAPI>()
    
    public func KakaoSendToken(token: String) {
        provider.request(.sendToken(token: token)) { result in
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
    
    public func sendAppleToken(userData: AppleUserData) {
        provider.request(.sendAppleLoginInfo(userData: userData)) { result in
            switch result {
            case .success(let response):
                do {
                    let serverResponse = try JSONDecoder().decode(LoginServerResponse.self, from: response.data)
                    print("애플 로그인 서버 응답: \(serverResponse)")
                } catch {
                    print("응답 실패 : \(error.localizedDescription)")
                }
            case.failure(let error):
                print("애플 로그인 서버 전송 실패: \(error.localizedDescription)")
            }
        }
    }
}
