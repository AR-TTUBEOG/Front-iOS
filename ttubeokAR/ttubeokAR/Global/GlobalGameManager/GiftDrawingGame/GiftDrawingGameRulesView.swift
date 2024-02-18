//
//  GameRoules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import SwiftUI

struct GiftDrawingGameRulesView: View {
    //MARK: - Property
    @ObservedObject var viewModel: GiftDrawingGameViewModel
    
    //MARK: - Body
    var body: some View {
        groupView
    }
    
    //MARK: - BasketBallGameRulesView
    
    private var groupView: some View {
        ZStack(alignment: .topLeading) {
            GameSettingSubTitle(title: "게임 규칙")
                .offset(x: 13)
            settingGameRules
                .offset(y: 30)
        }
        .frame(width: 310, height: 140, alignment: .top)
    }
    
 
    
    /// 농구게임 게임 규칙 설정
    private var settingGameRules: some View {
        VStack(alignment: .center, spacing: 8) {
            GameRulesTextView(label: "제한시간",
                              onMinusTapped: { viewModel.decreaseTime() },
                              valueLabel: "\(Int(viewModel.timeLimit))초",
                              onPlustTapped: { viewModel.increaseTime() }
            )
            
            Divider()
                .background(Color(red: 0.63, green: 0.62, blue: 0.95))
                .frame(height: 0.5)
            
            GameRulesTextView(label: "선물 개수",
                              onMinusTapped: { viewModel.decreaseGiftCount() },
                              valueLabel: "\(viewModel.giftCount)개",
                              onPlustTapped: { viewModel.increaseGifCount() }
            )
        }
        .frame(width: 280, height: 100, alignment: .center)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 19))
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .inset(by: 0.5)
                .stroke(Color.primary03, lineWidth: 0.5)
        )
    }
}
