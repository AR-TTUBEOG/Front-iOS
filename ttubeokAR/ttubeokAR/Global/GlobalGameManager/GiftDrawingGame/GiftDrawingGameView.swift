//
//  BasketBallGameView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct GiftDrawingGameView: View {
    //MARK: - Propery
    
    @ObservedObject var viewModel: GiftDrawingGameViewModel
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundComponent(topTitle: "선물 뽑기")
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
            GiftDrawingGameRulesView(viewModel: viewModel)
            GameBenefitsText(text: $viewModel.benefitsText)
            GameCouponView(selectBtn: $viewModel.selectCoupon)
            GameSettingFinishButton(viewModel: viewModel)
        })
        .frame(maxWidth: 300, maxHeight: 580)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 24))
        .offset(y: 20)
    }
}

struct GiftDrawingGameView_Previews: PreviewProvider {
    static var previews: some View {
        GiftDrawingGameView(viewModel: GiftDrawingGameViewModel())
            .previewLayout(.sizeThatFits)
    }
}
