//
//  WheelGameRuleView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/11/24.
//

import SwiftUI

struct WheelGameRuleView: View {
    
    @ObservedObject var viewModel: WheelGameViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GameSettingSubTitle(title: "게임 규칙")
                .offset(x: 13)
            rulesView
                .offset(y: 30)
        }
        .frame(width: 320, height: 265, alignment: .top)
    }
    
    //MARK: - WheelGameRuleView
    
    private var rulesView: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(0..<viewModel.texts.count, id: \.self) { index in
                WheelGameRulesSettingView(viewModel: viewModel, index: index)
            }
        }
        .frame(width: 300, height: 230)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 19))
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .inset(by: 0.5)
                .stroke(Color.primary03, lineWidth: 0.5)
        )
    }
}

struct WheelGameRulesView_Previews: PreviewProvider {
    static var previews: some View {
        WheelGameRuleView(viewModel: WheelGameViewModel())
            .previewLayout(.sizeThatFits)
    }
}
