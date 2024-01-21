//
//  MainContentView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/19/24.
//
import SwiftUI

struct LoginViewCycle: View {
    @State private var currentState: AppState = .login
    @State private var isShowingMainView = false

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
        .animation(.easeInOut(duration: 0.5), value: isShowingMainView)
    }
}

enum AppState {
    case login
    case nicknameSetting
    case mainView
}
