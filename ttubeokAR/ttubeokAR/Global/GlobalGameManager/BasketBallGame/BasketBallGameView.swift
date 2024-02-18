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
            BackgroundComponent(height: 720, topTitle: "농구 게임")
            gameStack
        }
        .clipShape(.rect(cornerRadius: 24))
        .onTapGesture {
            keyboardResponsive()
        }
    }
    
    //MARK: - BasketBallGameView
    
    private var gameStack: some View {
        VStack(alignment: .center, spacing: 20 , content: {
            BasketBallGameRulesView(viewModel: viewModel)
            GameBenefitsText(text: $viewModel.benefitsText)
            GameCouponView(selectBtn: $viewModel.selectCoupon)
        })
        .frame(width: 320, height: 630)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 24))
        .padding(.top, 10)
    }
}

struct BasketBallGameView_Previews: PreviewProvider {
    static var previews: some View {
        BasketBallGameView(viewModel: BasketBallGameViewModel())
            .previewLayout(.sizeThatFits)
    }
}
