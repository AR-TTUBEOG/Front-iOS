//
//  AppleLoginViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import AuthenticationServices
import SwiftUI

class AppleLoginManager: NSObject, ObservableObject {
    @Published var userData = AppleUserData()
    @Published var isLoggedIn = false
    private var loginViewModel = LoginViewModel()
    
    public func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
           if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
               DispatchQueue.main.async {
                   let userData = AppleUserData(
                       userIdentifier: appleIDCredential.user,
                       fullName: "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")",
                       email: appleIDCredential.email
                   )
                   self.loginViewModel.sendAppleToken(userData: userData)
                   self.isLoggedIn = true
               }
           }
       }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple 로그인 실패 : \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.isLoggedIn = false
        }
    }
}
