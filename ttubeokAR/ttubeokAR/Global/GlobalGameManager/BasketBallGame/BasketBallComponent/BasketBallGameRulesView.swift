//
//  GameRoules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import SwiftUI

struct BasketBallGameRulesView: View {
    //MARK: - Property
    @ObservedObject var viewModel: BasketBallGameViewModel
    
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
        .frame(maxWidth: 260, maxHeight: 172)
    }
    
 
    
    /// 농구게임 게임 규칙 설정
    private var settingGameRules: some View {
        VStack(alignment: .center, spacing: 8) {
            GameRulesTextView(label: "제한시간",
                              onMinusTapped: { viewModel.decreaseTime() },
                              valueLabel: "\(viewModel.timeLimit)초",
                              onPlustTapped: { viewModel.increaseTime() }
            )
            
            Divider()
                .background(Color(red: 0.63, green: 0.62, blue: 0.95))
                .frame(maxHeight: 0.5)
            
            GameRulesTextView(label: "공 개수",
                              onMinusTapped: { viewModel.decreaseBallCount() },
                              valueLabel: "\(viewModel.ballCount)개",
                              onPlustTapped: { viewModel.increaseBallCount() }
            )
            
            Divider()
                .background(Color(red: 0.63, green: 0.62, blue: 0.95))
                .frame(maxHeight: 0.5)
            
            GameRulesTextView(label: "성공 개수",
                              onMinusTapped: { viewModel.decreaseSuccessCount() },
                              valueLabel: "\(viewModel.successCount)개",
                              onPlustTapped: { viewModel.increaseSuccessCount() }
            )
        }
        .frame(maxWidth: 270, maxHeight: 143, alignment: .center)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 19))
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .inset(by: 0.5)
                .stroke(Color.primary03, lineWidth: 0.5)
        )
    }
}

#Preview {
    BasketBallGameRulesView(viewModel: BasketBallGameViewModel())
        .previewLayout(.sizeThatFits)
}
