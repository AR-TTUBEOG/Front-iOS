//
//  LoginView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import SwiftUI

/// 애플 및 카카오 로그인 선택 뷰
struct LoginView: View {
    
    //TODO: - 최초 또는 2회 이상 로그인 및 접속에 따른 뷰 전환 다르게 하기
    /**
     로그인 성공 시 닉네임 변경 화면으로 넘어가기 위한 액션
     최초 로그인에 한 해서만 작동하도록 수정!!
     */
    var transitionToNext: () -> Void
    
    //MARK: - Body
    
    var body: some View {
        allView
    }
    
    //MARK: - LoginViewComponent
    /// 화면 구성에 필요한 요소를 정리
    private var allView: some View {
        ZStack(alignment: .center) {
            loginBackground
            blackOpacityView
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    loginTitle
                    Spacer()
                        .frame(maxHeight: 154)
                    groupLoginButton
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.58)
            }
        }
    }
    
    private var groupLoginButton: some View {
        VStack(alignment: .center, spacing: 15) {
            centerLine
            VStack(alignment: .center) {
                KakaoLogin(transitionToNext: transitionToNext)
                AppleLogin(transitionToNext: transitionToNext)
            }
        }
    }
    
    /// 소셜 로그인 배경화면
    private var loginBackground: some View {
        Icon.loginBackground.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
    
    /// 배경화면 위 opacity 적용된 검은색 배경
    private  var blackOpacityView: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.6))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    /// 로그인 뷰 타이틀
    private var loginTitle: some View {
        Text("뚜벅과 함께 \n 걸어 볼까요?")
            .font(.sandol(type: .bold, size: 32))
            .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 4)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.white)
            .kerning(3.36)
            .frame(maxWidth: 350, maxHeight: 82, alignment: .center)
    }
    
    /// 타이틀과 간편 로그인 버튼 사이 분리선
    private var centerLine: some View {
        HStack(alignment: .center, spacing: 4) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: 130, maxHeight: 0.5)
                .background(Color.white)
            
            Text("간편 로그인")
                .font(.sandol(type: .medium, size: 12))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 70, maxHeight: 16, alignment: .center)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: 130.41211, maxHeight: 0.5)
                .background(Color.white)
        }
    }
}

    //MARK: - Preview

#Preview {
    LoginView(transitionToNext: {print("Hello")})
}
