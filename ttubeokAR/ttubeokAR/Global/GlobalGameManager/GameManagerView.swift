//
//  GameManagerView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/5/24.
//

import SwiftUI

struct GameManagerView: View {
    
    //MARK: - Property
    @State private var showBasketBallGameSetting = false
    @State private var showGiftDrawingGameSetting = false
    @State private var showWhellGameSetting = false
    
    //MARK: Body
    var body: some View {
        allView
    }
    
    //MARK: - GameManagerView
    private var allView: some View {
        VStack(alignment: .center, spacing: 15) {
            gameButtonView(title: "농구 게임",
                           tipButtonAction: { print("농구게임 팁버튼") },
                           gameButtonAction: { showBasketBallGameSetting = true } )
            gameButtonView(title: "선물 뽑기",
                           tipButtonAction: { print("선물 뽑기") },
                           gameButtonAction: { showGiftDrawingGameSetting = true })
            gameButtonView(title: "돌림판 게임",
                           tipButtonAction: { print("돌림판 게임") },
                           gameButtonAction: { showWhellGameSetting = true })
        }
    }
}

#Preview {
    GameManagerView()
}
