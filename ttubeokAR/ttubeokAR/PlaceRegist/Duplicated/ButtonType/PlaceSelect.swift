//
//  PlaceSelect.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct PlaceSelect: View {
    
    //MARK: - Property
    let type: PlaceSelectType
    @Binding var isChecked: Bool
    
    //MARK: - Body
    var body: some View {
            VStack(alignment: .center, spacing: 28) {
                placeTitle
                selectButton
                placeSubtitle
            }
            .frame(maxWidth: 200, maxHeight: 320)
            .padding(.top, 10)
            .background(Color.clear)
    }
    
    //MARK: - PlaceSelectView
    
    /// 산책 또는 매장 등록에 대한 타이틀
    private var placeTitle: some View {
        Text(title)
            .frame(maxWidth: 95, maxHeight: 21)
            .font(.sandol(type: .bold, size: 25))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.textPink)       
    }
    
    @ViewBuilder
    /// 산책 또는 매장 등록에 대한 아이콘
    private var selectButton: some View {
        switch type {
        case .walk:
            WalkSelectButton(isChecked: $isChecked)
        case .market:
            MarketSelectButton(isChecked: $isChecked)
        }
    }
    
    @ViewBuilder
    /// 산책 또는 매장 등록에 대한 서브 타이틀
    private var placeSubtitle: some View {
        Text(customAttributedString(for: subtitle,highlight: highlight))
            .font(.sandol(type: .bold, size: 15))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.white)
            .frame(maxWidth: 220, maxHeight: 51)
    }
    
    private func customAttributedString(for text: String, highlight: String) -> AttributedString {
        var attr = AttributedString(text)
        if let range = attr.range(of: highlight) {
            attr[range].font = .sandol(type: .bold, size: 15)
            attr[range].foregroundColor = .textBlue
        }
        return attr
    }
    
    private var title: String {
        switch type {
        case .market:
            return "매장"
        case .walk:
            return "산책 스팟"
        }
    }
    
    private var subtitle: String {
        switch type {
        case .market:
            return "매장 관계자만 \n 등록 할 수 있어요!"
        case .walk:
            return "모든 사람이 \n 등록할 수 있어요!"
        }
    }
    
    private var highlight: String {
        switch type {
        case .market:
            return "매장 관계자"
        case .walk:
            return "모든 사람"
        }
    }
}

// PlaceSelectType 열거형의 가정된 정의

// PlaceSelect 뷰에 대한 프리뷰
struct PlaceSelect_Previews: PreviewProvider {
    @State static var isChecked = true

    static var previews: some View {
        // walk 타입의 PlaceSelect 뷰 프리뷰
        PlaceSelect(type: .walk, isChecked: $isChecked)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("산책 스팟 선택")

        // market 타입의 PlaceSelect 뷰 프리뷰
        PlaceSelect(type: .market, isChecked: $isChecked)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("매장 선택")
    }
}

