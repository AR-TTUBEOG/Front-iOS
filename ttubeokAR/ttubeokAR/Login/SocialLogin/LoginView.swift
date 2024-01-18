//
//  LoginView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/17/24.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
            allView
    }
    
    private var allView: some View {
        ZStack(alignment: .top) {
            loginBackground
            blackOpacityView
            VStack(alignment: .center) {
                loginTitle
                    .padding(.top, 200)
                centerLine
                    .padding(.top, 80)
                KakaoLogin()
                AppleLogin()
                
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
    
    private  var blackOpacityView: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.7))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    private var loginTitle: some View {
        Text("뚜벅과 함께 \n 걸어 볼까요?")
            .font(.sandol(type: .bold, size: 30))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.white)
            .frame(maxWidth: 350, maxHeight: 90, alignment: .top)
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
    LoginView()
}
