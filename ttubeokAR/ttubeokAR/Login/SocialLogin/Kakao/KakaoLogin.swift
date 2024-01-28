//
//  KakaoLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import Foundation
import SwiftUI

/// 카카오 로그인 버튼 구현
struct KakaoLogin: View {
    
    //MARK: - Property
    var transitionToNext: () -> Void
    @ObservedObject var kakaoLoginManager = KakaoLoginManager()
    
    //MARK: - Body
    var body: some View {
        kakaoBtn
            .padding(.top, 20)
            .onChange(of: kakaoLoginManager.isLoggedIn) { oldValue, newValue in
                if newValue {
                    transitionToNext()
                }
            }
    }
    //MARK: - KakaoLoginView
    private var kakaoBtn: some View {
        Button(action: {
            kakaoLoginManager.loginAndSendToken()
        }) {
            Icon.kakao.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 300, maxHeight: 43)
        }
    }
}

