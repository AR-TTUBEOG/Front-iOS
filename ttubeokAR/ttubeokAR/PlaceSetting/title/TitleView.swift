//
//  TitleView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct TitleView: View {
    //MARK: - Property
    let titleText: String
    let highlightText: String
    let subtitleText: String?
    let spacing: CGFloat
    
    //MARK: - Body
    var body: some View {
        title
    }
    
    @ViewBuilder
    private var title: some View {
        VStack(alignment: .center, spacing: spacing) {
            Text(customAttributedSting(for: titleText, hightlight: highlightText))
                .font(.sandol(type: .bold, size: 28))
                .frame(maxWidth: 339, maxHeight: 79)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
            
            if let subtitle = subtitleText {
                Text(subtitle)
                    .font(.sandol(type: .light, size: 20))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 274, maxHeight: 60)
                    .foregroundColor(Color(red: 0.92, green: 0.9, blue: 0.97).opacity(0.8))
            }
        }
    }
    
    private func customAttributedSting(for text: String, hightlight: String) -> AttributedString {
        var attr = AttributedString(text)
        if let range = attr.range(of: hightlight) {
            attr[range].font = .sandol(type: .bold, size: 28)
            attr[range].foregroundColor = .primary03
        }
        return attr
    }
}
