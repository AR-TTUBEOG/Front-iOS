//
//  AppleLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct AppleLogin: View {
    
    var body: some View {
        appleLogin
            .padding(.top, 18)
    }
    
    private var appleLogin: some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("appleLogin successful")
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        let userIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                    default:
                        break
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        )
        .signInWithAppleButtonStyle(.whiteOutline)
        .frame(maxWidth: 300, maxHeight: 45)
    }
}
