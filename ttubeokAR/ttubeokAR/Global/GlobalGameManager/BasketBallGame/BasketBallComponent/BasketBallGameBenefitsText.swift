//
//  BasketBallGameBenefitsText.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/7/24.
//

import SwiftUI

struct BasketBallGameBenefitsText: View {
    //MARK: - Property
    @ObservedObject var viewModel: BasketBallGameViewModel
    
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            GameSettingSubTitle(title: "혜택 문구")
                .offset(x: 13)
            GameBenefitsTextField(text: $viewModel.benefitsText)
                .offset(y: 30)
        }
        .frame(maxWidth: 260, maxHeight: 172)
    }
    
}

#Preview {
    BasketBallGameBenefitsText(viewModel: BasketBallGameViewModel())
}
