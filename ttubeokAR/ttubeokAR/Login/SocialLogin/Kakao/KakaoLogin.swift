//
//  KakaoLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import Foundation
import SwiftUI

struct KakaoLogin: View {
    var transitionToNext: () -> Void
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        kakaoBtn
            .padding(.top, 38.91)
            .onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
                if newValue {
                    transitionToNext()
                }
            }
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
    }
}

