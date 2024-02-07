//
//  SelectMarketType.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import SwiftUI

enum MarketTypeName {
    case restaurant
    case cafe
    case none
}

struct SelectMarketType: View {
    //MARK: - Property
    let marketType: MarketTypeName
    @Binding var isSelected: Bool
    @Binding var selectedMarketType: String
    
    //MARK: - Body
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
            self.selectedMarketType = marketTypeName(type: marketType)
        }, label: {
            groupView
            .frame(maxWidth: 75, maxHeight: 32, alignment: .center)
            .background(isSelected ? Color(red: 0.63, green: 0.62, blue: 0.95).opacity(0.60) : Color(red: 0.92, green: 0.90, blue: 0.97))
            .clipShape(.rect(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.63, green: 0.62, blue: 0.95), lineWidth: isSelected ? 0.6 : 0.5)
            )
        })
        
    }
    
    //MARK: - SelectedMarketTypeView
    
    /// 그룹으로 지정한 뷰(텍스트와 이모티콘)
    private var groupView: some View {
        HStack(alignment: .center, spacing: 2) {
            (isSelected ? selectedMarketTypeImage(type: marketType) : notSelectedMarketTypeImage(type: marketType))
                .resizable()
                .frame(maxWidth: 10, maxHeight: 17)
                .aspectRatio(contentMode: .fill)
            
            Text(marketTypeName(type: marketType))
                .font(.sandol(type: .regular, size: 14))
                .foregroundStyle(isSelected ? Color.white : Color.primary03)
                .frame(maxWidth: 37, maxHeight: 20, alignment: .bottom)
        }
        .frame(maxWidth: 55, maxHeight: 22, alignment: .center)
        .padding(.leading, 2)
    }
    
    /// 마켓타입에 따른 텍스트 반환
    /// - Parameter type: 마켓 타입 지정
    /// - Returns: 문자열 반환
    private func marketTypeName(type: MarketTypeName) -> String {
        switch type {
        case .restaurant:
            return "음식점"
        case .cafe:
            return "카페"
        case .none:
            return "X"
        }
    }
    
    /// 마켓 타입에 따른 선택되었을 때 이미지 반환
    /// - Parameter type: 마켓 타입 반환
    /// - Returns: 선택되었을 때 이미지 반환
    private func selectedMarketTypeImage(type: MarketTypeName) -> Image {
        switch type {
        case .restaurant:
            return Icon.whiteRest.image
        case .cafe:
            return Icon.whiteDrink.image
        case .none:
            return Image(systemName: "questionMark")
        }
    }
    
    /// 마켓 타입에 따른 선택되지 않았을 때 이미지 반환
    /// - Parameter type: 마켓 타입 반환
    /// - Returns: 선택되지 않았을 때 이미지 반환
    private func notSelectedMarketTypeImage(type: MarketTypeName) -> Image {
        switch type {
        case .restaurant:
            return Icon.restaurant.image
        case .cafe:
            return Icon.drink.image
        case .none:
            return Image(systemName: "questionMark.circle")
        }
    }
}
