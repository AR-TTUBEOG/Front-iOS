//
//  AppleLoginViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import AuthenticationServices
import SwiftUI

class AppleLoginViewModel: NSObject, ObservableObject {
    @Published var userData = AppleUserData()
    @Published var isSignIn: Bool = false
    
    public func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension AppleLoginViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            DispatchQueue.main.async {
                self.userData.userIdentifier = appleIDCredential.user
                self.userData.fullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
                self.userData.email = appleIDCredential.email
                self.isSignIn = true
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Loginerror")
    }
}
