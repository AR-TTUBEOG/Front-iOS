//
//  TitleView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct CustomTitleView: View {
    //MARK: - Property
    let titleText: String
    let titleRangeColor: Color
    let highlightText: [String]
    let subtitleText: String?
    let subtitleSize: CGFloat?
    let titleWidth: CGFloat
    let titleHeight: CGFloat
    let subtitleWidth: CGFloat?
    let subtitleHeight: CGFloat?
    let spacing: CGFloat
    let textAlignment: TextAlignment
    let frameAlignment: Alignment
    
    //MARK: - init
    /// 커스텀 타이틀에 대한 init
    /// - Parameters:
    ///   - titleText: 타이틀에 작성할 String
    ///   - highlightText: 타이틀 중 지정 단어에 대한 별도의 스타일 적용
    ///   - subtitleText: 서브 타이틀 String
    ///   - subtitleSize: 서븥 타이틀 크기 지정
    ///   - titleWidth: 타이틀 가로 길이 지정
    ///   - titleHeight: 타이틀 높이 길이 지정
    ///   - subtitleWidth: 서브 타이틀 길이 지정
    ///   - subtitleHeight: 서브 타이틀 높이 지정
    ///   - spacing: Spacing 지정
    ///   - textAlignment: 텍스트 정렬
    ///   - frameAlignment: frame 정렬
    init(titleText: String,
         titleRangeColor: Color = Color.primary03,
         highlightText: [String],
         subtitleText: String?,
         subtitleSize: CGFloat? = 15,
         titleWidth: CGFloat = 350,
         titleHeight: CGFloat,
         subtitleWidth: CGFloat? = 350,
         subtitleHeight: CGFloat? = 30,
         spacing: CGFloat = 11,
         textAlignment: TextAlignment,
         frameAlignment: Alignment
    ) {
            self.titleText = titleText
            self.titleRangeColor = titleRangeColor
            self.highlightText = highlightText
            self.subtitleText = subtitleText
            self.subtitleSize = subtitleSize
            self.titleWidth = titleWidth
            self.titleHeight = titleHeight
            self.subtitleWidth = subtitleWidth
            self.subtitleHeight = subtitleHeight
            self.spacing = spacing
            self.textAlignment = textAlignment
            self.frameAlignment = frameAlignment
    }

    
    //MARK: - Body
    
    var body: some View {
        title
    }
    
    @ViewBuilder
    /// 중복되는 상단 타이틀 작성
    private var title: some View {
        VStack(alignment: .center, spacing: spacing) {
            Text(customAttributedSting(for: titleText, highlights: highlightText))
                .font(.sandol(type: .bold, size: 28))
                .frame(maxWidth: titleWidth, maxHeight: titleHeight, alignment: frameAlignment)
                .foregroundStyle(Color.textPink)
                .multilineTextAlignment(textAlignment)
            
            if let subtitle = subtitleText {
                Text(subtitle)
                    .font(.sandol(type: .light, size: subtitleSize ?? 0))
                    .lineSpacing(1.2)
                    .frame(maxWidth: subtitleWidth ?? 0, maxHeight: subtitleHeight ?? 0, alignment: frameAlignment)
                    .foregroundStyle(Color.textPink)
                    .multilineTextAlignment(textAlignment)
            }
        }
    }
    
    /// 타이틀의 특정 단어에 대한 스타일 지정
    /// - Parameters:
    ///   - text: 전체 텍스트 값
    ///   - highlight: 전체 텍스트 중 일부 스타일 지정을 위한 텍스트
    /// - Returns: 스타일 지정에 대한 리턴값
    private func customAttributedSting(for text: String, highlights: [String]) -> AttributedString {
        var attr = AttributedString(text)
        for highlight in highlights {
            if let range = attr.range(of: highlight) {
                attr[range].font = .sandol(type: .bold, size: 28)
                attr[range].foregroundColor = titleRangeColor
            }
        }
        return attr
    }
}
