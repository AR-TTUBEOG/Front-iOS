//
//  AppleLoginViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import AuthenticationServices
import SwiftUI

class AppleLoginManager: NSObject, ObservableObject {
    
    //MARK: - Property
    @Published var userData: AppleUserData?
    @Published var isLoggedIn = false
    var loginViewModel: LoginViewModel?
    
    //MARK: - AppleLoginManagerFunction
    /// 애플로 로그인 시도 응답 데이터 : 풀네임, 이메일
    public func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

//MARK: - AppleLoginExtension
extension AppleLoginManager: ASAuthorizationControllerDelegate {
    
    /// 애플 로그인 성공 시 유저 데이터 받아오기
    /// 유저 데이터 받아 온 후 서버로 유저 데이터 보내기
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
           if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
               DispatchQueue.main.async {
                   let userData = AppleUserData(
                    userIdentifier: appleIDCredential.user,
                    firstName: appleIDCredential.fullName?.givenName ?? "",
                    lastName: appleIDCredential.fullName?.familyName ?? "",
                    email: appleIDCredential.email ?? "",
                    authorizationCode: String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .utf8),
                    identityToken: String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8)
                   )
                   self.loginViewModel?.sendAppleToken(userData: userData)
                   self.isLoggedIn = true
                   print("authorizationCode : \(userData.authorizationCode ?? "")")
                   print("identityToken : \(userData.identityToken ?? "")")
               }
           }
       }
    
    /// 로그인 실패 시 화면 전환 변수 false
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple 로그인 실패 : \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.isLoggedIn = false
        }
    }
}
