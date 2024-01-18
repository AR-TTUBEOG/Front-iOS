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
            .padding(.top, 18.81)
    }
    
    private var appleLoginBtn: some View {
        ZStack {
            if viewModel.isSignIn {
                Text("AppleLogin 성공")
            } else {
                Button(action: viewModel.signInWithApple) {
                    Text(" Sign in with Apple")
                        .frame(maxWidth: 300, maxHeight: 45)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .font(.sandol(type: .light, size: 20))
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    AppleLogin(viewModel: AppleLoginViewModel())
}

