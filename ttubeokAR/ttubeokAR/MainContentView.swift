//
//  MainContentView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/19/24.
//

import SwiftUI

import SwiftUI

struct MainContentView: View {
    @State private var isShowingMainView = false

    var body: some View {
        ZStack {
            if isShowingMainView {
                MainViewControl()
                    .transition(.opacity)
            } else {
                LoginView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isShowingMainView)
    }
}



#Preview {
    MainContentView()
}
