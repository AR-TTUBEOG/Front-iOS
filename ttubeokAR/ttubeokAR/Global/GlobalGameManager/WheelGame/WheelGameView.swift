//
//  WheelGameView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct WheelGameView: View {
    //MARK: - Propery
    
    @ObservedObject var viewModel: WheelGameViewModel
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundComponent(height: 1020, topTitle: "선물 뽑기")
            gameStack
        }
        .clipShape(.rect(cornerRadius: 24))
        .onTapGesture {
            keyboardResponsive()
            viewModel.activePopoverIndex = nil
        }
    }
    
    //MARK: - BasketBallGameView
    
    private var gameStack: some View {
            VStack(spacing: 30) {
                WheelGameRuleView(viewModel: viewModel)
                WheelGameShapeView(viewModel: viewModel)
                    .offset(y: 20)
                GameCouponView(selectBtn: $viewModel.selectCoupon)
                GameSettingFinishButton(viewModel: viewModel)
            }
            .padding(.top, 5)
            .frame(width: 330, height: 930)
            .background(Color(red: 0.25, green: 0.24, blue: 0.37))
            .clipShape(.rect(cornerRadius: 24))
            .scrollIndicators(.hidden)
    }
}

struct WheelGameView_Previews: PreviewProvider {
    static var previews: some View {
        WheelGameView(viewModel: WheelGameViewModel())
            .previewLayout(.sizeThatFits)
    }
}
