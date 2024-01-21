//
//  AppleLoginView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import SwiftUI
import AuthenticationServices

struct AppleLogin: View {
    @ObservedObject var viewModel = AppleLoginViewModel()
    
    var body: some View {
        appleLoginBtn
            .padding(.top, 19)
    }
    
    private var appleLoginBtn: some View {
        ZStack {
            if viewModel.isSignIn {
                Text("AppleLogin 성공")
            } else {
                Button(action: viewModel.signInWithApple) {
                    Icon.apple.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 300, maxHeight: 43)
                }
            }
        }
    }
}

#Preview {
    AppleLogin(viewModel: AppleLoginViewModel())
}

