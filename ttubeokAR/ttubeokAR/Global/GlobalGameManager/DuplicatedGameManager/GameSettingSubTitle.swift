//
//  GameTopTitleComponent.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/7/24.
//

import SwiftUI

struct GameSettingSubTitle: View {
    
    var title: String
    
    var body: some View {
        topTitle
    }
    
    /// 게임 규칙 이름
    private var topTitle: some View {
        Text(title)
            .frame(maxWidth: 78, maxHeight: 50, alignment: .top)
            .font(.sandol(type: .semiBold, size: 14))
            .padding(.top, 10)
            .background(Color(red: 0.52, green: 0.54, blue: 0.92).opacity(0.20))
            .clipShape(.rect(cornerRadius: 19))
            .foregroundStyle(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.52, green: 0.54, blue: 0.92), lineWidth: 0.50)
            )
        
    }
}
