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
    var transitionToNext: () -> Void
    @ObservedObject var appleLogionManager = AppleLoginManager()
    
    var body: some View {
        appleLoginBtn
            .padding(.top, 19)
            .onChange(of: appleLogionManager.isLoggedIn) { oldValue, newValue in
                if newValue {
                    transitionToNext()
                }
            }
    }
    
    private var appleLoginBtn: some View {
        Button(action: {
            appleLogionManager.signInWithApple()
        }) {
            Icon.apple.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 300, maxHeight: 43)
        }
    }
}
