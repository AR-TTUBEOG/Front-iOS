//
//  KakaoLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import Foundation
import SwiftUI

struct KakaoLogin: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        kakaoBtn
            .padding(.top, 38.91)
    }
    
    private var kakaoBtn: some View {
        Button(action: {
            viewModel.loginAndSendToken()
        }) {
            Icon.kakao.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 43)
        }
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            NextContentView()
        }
    }
}

#Preview {
    KakaoLogin(viewModel: LoginViewModel())
}
