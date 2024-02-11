//
//  WheelGameRuleView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/11/24.
//

import SwiftUI

struct WheelGameRuleView: View {
    
    @ObservedObject var viewModel = WheelGameViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 0.25, green: 0.24, blue: 0.37).ignoresSafeArea(.all)
            rulesView
        }
        .onTapGesture {
            viewModel.activePopoverIndex = nil
        }
    }
    
    //MARK: - WheelGameRuleView
    
    private var rulesView: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(0..<viewModel.texts.count, id: \.self) { index in
                WheelGameRulesSettingView(viewModel: viewModel, wheelGameSetting: viewModel.wheelGameSetting[index], index: index)
            }
        }
        
    }
}

#Preview {
    WheelGameRuleView()
}
