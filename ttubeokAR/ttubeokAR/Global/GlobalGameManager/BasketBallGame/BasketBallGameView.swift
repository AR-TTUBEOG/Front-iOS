//
//  BasketBallGameView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct BasketBallGameView: View {
    //MARK: - Propery
    
    @ObservedObject var viewModel: BasketBallGameViewModel
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundComponent(topTitle: "농구 게임")
            gameStack
        }
    }
    
    //MARK: - BasketBallGameView
    
    private var gameStack: some View {
        VStack(alignment: .center, spacing: 30 , content: {
            BasketBallGameRulesView(viewModel: viewModel)
            GameBenefitsText(text: $viewModel.benefitsText)
            GameCouponView(selectBtn: $viewModel.selectCoupon)
            
        })
    }
}

#Preview {
    BasketBallGameView(viewModel: BasketBallGameViewModel())
}
