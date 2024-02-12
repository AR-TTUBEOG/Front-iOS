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
            BackgroundComponent(topTitle: "선물 뽑기")
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
        ScrollView(showsIndicators: false) {
            VStack(spacing: 50) {
                WheelGameRuleView(viewModel: viewModel)
                WheelGameShapeView(viewModel: viewModel)
                    .offset(y: 50)
                GameCouponView(selectBtn: $viewModel.selectCoupon)
                GameSettingFinishButton(viewModel: viewModel)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: 300, maxHeight: 600)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 24))
        .offset(y: 20)
    }
}

struct WheelGameView_Previews: PreviewProvider {
    static var previews: some View {
        WheelGameView(viewModel: WheelGameViewModel())
            .previewLayout(.sizeThatFits)
    }
}
