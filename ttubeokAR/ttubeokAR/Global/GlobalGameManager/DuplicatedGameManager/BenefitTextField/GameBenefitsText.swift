//
//  BasketBallGameBenefitsText.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/7/24.
//

import SwiftUI

struct GameBenefitsText: View {
    //MARK: - Property
    
    @Binding var text: String
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            GameSettingSubTitle(title: "혜택 문구")
                .offset(x: 13)
            GameBenefitsTextField(text: $text)
                .offset(y: 30)
        }
        .frame(maxWidth: 260, maxHeight: 130, alignment: .top)
    }
    
}
