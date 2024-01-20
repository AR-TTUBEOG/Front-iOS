//
//  MainContentView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/19/24.
//
import SwiftUI

struct NextContentView: View {
    @State private var isShowingMainView = false

    var body: some View {
        ZStack {
            if isShowingMainView {
                MainViewControl()
                    .transition(.opacity)
            } else {
                NicknameSettingLogin(viewModel: NicknameSettingViewModel(), showMainView: $isShowingMainView)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isShowingMainView)
    }
}



#Preview {
    NextContentView()
}
