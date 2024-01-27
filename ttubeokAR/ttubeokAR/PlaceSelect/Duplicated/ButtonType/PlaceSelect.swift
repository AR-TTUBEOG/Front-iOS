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
        VStack(alignment: .center, spacing: 38) {
            placeTitle
            selectButton
            placeSubtitle
        }
        .frame(maxWidth: 180)
        .padding(.top, 10)
        .background(Color.clear)
    }
    
    //MARK: - PlaceSelectView
    
    private var placeTitle: some View {
        Text(title)
            .frame(maxWidth: 95, maxHeight: 21)
            .font(.sandol(type: .bold, size: 25))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.textPink)       
    }
    
    @ViewBuilder
    private var selectButton: some View {
        switch type {
        case .walk:
            WalkSelectButton(isChecked: $isChecked)
        case .market:
            MarketSelectButton(isChecked: $isChecked)
        }
    }
    
    @ViewBuilder
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
