//
//  AppleLoginView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import SwiftUI
import AuthenticationServices

/// 애플 로그인 기능 버튼
struct AppleLogin: View {
    //MARK: - Property
    var transitionToNext: () -> Void
    @ObservedObject var appleLogionManager = AppleLoginManager()
    @StateObject var loginViewModel: LoginViewModel
    //MARK: - Body
    var body: some View {
        appleLoginBtn
            .padding(.top, 19)
            .onChange(of: appleLogionManager.isLoggedIn) { oldValue, newValue in
                if newValue {
                    transitionToNext()
                }
            }
            .onAppear{
                appleLogionManager.loginViewModel = loginViewModel
            }
    }
    
    //MARK: - AppleLoginView
    private var appleLoginBtn: some View {
        Button(action: {
            appleLogionManager.signInWithApple()
        }) {
            Icon.apple.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 320, maxHeight: 43)
        }
    }
}
