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
    
    @ObservedObject private var basketViewModel = BasketBallGameViewModel()
    @ObservedObject private var giftDrawingViewModel = GiftDrawingGameViewModel()
    @ObservedObject private var wheelGameViewModel = WheelGameViewModel()
    
    //MARK: Body
    var body: some View {
        allView
    }
    
    //MARK: - GameManagerView
    private var allView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                GameButtonView(title: "농구 게임",
                               gameButtonAction: { showBasketBallGameSetting.toggle() } )
                
                if showBasketBallGameSetting {
                    BasketBallGameView(viewModel: basketViewModel)
                }
                
                GameButtonView(title: "선물 뽑기",
                               gameButtonAction: { showGiftDrawingGameSetting.toggle() })
                
                if showGiftDrawingGameSetting {
                    GiftDrawingGameView(viewModel: giftDrawingViewModel)
                }
                
                GameButtonView(title: "돌림판 게임",
                               gameButtonAction: { showWhellGameSetting.toggle() })
                
                if showWhellGameSetting {
                    WheelGameView(viewModel: wheelGameViewModel)
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(width: 360)
    }
}

struct GameManager_Preview: PreviewProvider {
    static var previews: some View {
        GameManagerView()
            .previewLayout(.sizeThatFits)
    }
}
