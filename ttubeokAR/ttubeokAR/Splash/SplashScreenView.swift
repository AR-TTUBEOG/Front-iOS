//
//  SplashScreenView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import SwiftUI

struct SplashScreenView: View {
    //MARK: Property
    
    //MARK: Body
    var body: some View {
        ZStack(alignment: .center) {
            backgroundSplashImage
            blackOpacityView
            centerLogo
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.changeToLoginView()
            }
        }
    }
    
    //MARK: SplashScreenView
    
    /// 스플래쉬 화면 배경화면 사진
    private var backgroundSplashImage: some View {
        Icon.loginBackground.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
    
    /// 배경화면 위 검은 색 배경 처리
    private var blackOpacityView: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(Color.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.6))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    /// 뚜벅 로고 이미지
    private var centerLogo: some View {
        Icon.logoImage.image
            .resizable()
            .frame(maxWidth: 90, maxHeight: 92)
            .aspectRatio(contentMode: .fill)
    }
    
    private func changeToLoginView() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let newRootView = UIHostingController(rootView: LoginViewCycle())
            appDelegate.changeRootSplashView(newRootView, animated: true)
        }
    }
}

#Preview {
    SplashScreenView()
}
