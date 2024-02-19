//
//  MarketGameRegistView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/19/24.
//

import SwiftUI

struct MarketGameRegistView: View {
    
    @StateObject var viewModel: MarketViewModel
    
    var body: some View {
        ScrollView {
            sevenView
        }
        .background(Color.background)
    }
    
    //MARK: - sevenView
    
    private var sevenTitle: some View {
        CustomTitleView(titleText: "리워드를 선택해주세요",
                        highlightText: ["리워드"],
                        subtitleText: "방문 고객에게 게임을 통해 혜택을 주세요!",
                        titleHeight: 45,
                        spacing: 10,
                        textAlignment: .leading,
                        frameAlignment: .topLeading
        )
    }
    
    private var sevenBenefitMethod: some View {
        VStack(alignment: .leading, spacing: 30, content: {
            Text("헤택을 제공할 방법을 선택해주세요!")
                .font(.sandol(type: .bold, size: 16))
                .foregroundStyle(Color.textPink)
                .frame(width: 300, alignment: .leading)
            
            GameManagerView(basketViewModel: viewModel.basketBallViewModel, giftDrawingViewModel: viewModel.giftViewModel, wheelGameViewModel: viewModel.wheelGameViewModel)
        })
        .frame(width: 320)
    }
    
    private var sevenView: some View {
        VStack(alignment: .leading, spacing: 35, content: {
            sevenTitle
            sevenBenefitMethod
                .padding(.leading, 15)
        })
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }

}

#Preview {
    MarketGameRegistView(viewModel: MarketViewModel())
}
