//
//  MainContentView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/19/24.
//
import SwiftUI

//TODO: 토큰 검증을 통한 뷰 전환 다르게 하기
/// 로그인 상태, 닉네임 생성에 따른 뷰 전환
/// 최초 접속시에만 이루어지도록 해야함
/// 추후 토큰을 이용해서 검증할 필요 있다.
struct LoginViewCycle: View {
    
    //MARK: - Property
    @State private var currentState: AppState = .login
    @StateObject private var loginViewModel = LoginViewModel()
    
    //MARK: - Body
    var body: some View {
        ZStack {
            switch currentState {
            case .login:
                LoginView(transitionToNext: { currentState = .nicknameSetting})
            case .nicknameSetting:
                NicknameSettingLogin(transitionToNext: { currentState = .mainView}, viewModel: NicknameSettingViewModel())
            case .mainView:
                MainViewControl()
            }
        }
        .onAppear {
            loginViewModel.checkLoginStatus()
            currentState = loginViewModel.savedLoginToken ? .mainView : .login
        }
    }
}
    //MARK: - rootViewCase

enum AppState {
    case login
    case nicknameSetting
    case mainView
}
