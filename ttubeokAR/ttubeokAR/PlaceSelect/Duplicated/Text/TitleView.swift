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
    let subtitleSize: CGFloat?
    let titleWidth: CGFloat
    let titleHeight: CGFloat
    let subtitleWidth: CGFloat?
    let subtitleHeight: CGFloat?
    let spacing: CGFloat

    
    //MARK: - Body
    var body: some View {
        title
    }
    
    @ViewBuilder
    /// 중복되는 상단 타이틀 작성
    private var title: some View {
        VStack(alignment: .center, spacing: spacing) {
            Text(customAttributedSting(for: titleText, highlight: highlightText))
                .font(.sandol(type: .bold, size: 28))
                .frame(maxWidth: titleWidth, maxHeight: titleHeight)
                .foregroundStyle(Color.textPink)
                .multilineTextAlignment(.center)
            
            if let subtitle = subtitleText {
                Text(subtitle)
                    .font(.sandol(type: .light, size: subtitleSize ?? 0))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: subtitleWidth ?? 0, maxHeight: subtitleHeight ?? 0)
                    .foregroundColor(Color(red: 0.92, green: 0.9, blue: 0.97).opacity(0.8))
            }
        }
    }
    
    /// 타이틀의 특정 단어에 대한 스타일 지정
    /// - Parameters:
    ///   - text: 전체 텍스트 값
    ///   - highlight: 전체 텍스트 중 일부 스타일 지정을 위한 텍스트
    /// - Returns: 스타일 지정에 대한 리턴값
    private func customAttributedSting(for text: String, highlight: String) -> AttributedString {
        var attr = AttributedString(text)
        if let range = attr.range(of: highlight) {
            attr[range].font = .sandol(type: .bold, size: 28)
            attr[range].foregroundColor = .primary03
        }
        return attr
    }
}
