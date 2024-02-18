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
            print(self.selectedMarketType)
        }, label: {
            groupView
            .frame(width: 90, height: 40, alignment: .center)
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
                .frame(width: 14, height: 23)
                .aspectRatio(contentMode: .fill)
            
            Text(buttonTypeName(type: marketType))
                .font(.sandol(type: .regular, size: 16))
                .foregroundStyle(isSelected ? Color.white : Color.primary03)
                .frame(width: 45, height: 24, alignment: .bottom)
        }
        .frame(width: 70, height: 25, alignment: .center)
        .padding(.leading, 2)
    }
    
    /// 마켓타입에 따른 텍스트 반환
    /// - Parameter type: 마켓 타입 지정
    /// - Returns: 문자열 반환
    private func marketTypeName(type: MarketTypeName) -> String {
        switch type {
        case .restaurant:
            return "RESTAURANT"
        case .cafe:
            return "CAFE"
        case .none:
            return "X"
        }
    }
    
    private func buttonTypeName(type: MarketTypeName) -> String {
        switch type {
        case .restaurant:
            return "식당"
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
