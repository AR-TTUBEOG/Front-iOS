//
//  LoginView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import SwiftUI

struct LoginView: View {
    var transitionToNext: () -> Void
    var body: some View {
        allView
    }
    
    private var allView: some View {
        ZStack(alignment: .center) {
            loginBackground
            blackOpacityView
            VStack(alignment: .center) {
                loginTitle
                Spacer()
                    .frame(maxHeight: 154)
                centerLine
                KakaoLogin(transitionToNext: transitionToNext)
                AppleLogin(transitionToNext: transitionToNext)
            }
            .offset(y: 60)
        }
    }
    
    /// 소셜 로그인 배경화면
    private var loginBackground: some View {
        Icon.loginBackground.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
    
    private  var blackOpacityView: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.6))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    private var loginTitle: some View {
        Text("뚜벅과 함께 \n 걸어 볼까요?")
            .font(.sandol(type: .bold, size: 28))
            .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 4)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.white)
            .kerning(3.36)
            .frame(maxWidth: 350, maxHeight: 80, alignment: .center)
    }
    
    private var centerLine: some View {
        HStack(alignment: .center, spacing: 4) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: 119.41211, maxHeight: 0.5)
                .background(Color.white)
            
            Text("간편 로그인")
                .font(.sandol(type: .medium, size: 12))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 70, maxHeight: 16, alignment: .center)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: 119.41211, maxHeight: 0.5)
                .background(Color.white)
        }
    }
}

#Preview {
    LoginView(transitionToNext: {print("Hello")})
}
