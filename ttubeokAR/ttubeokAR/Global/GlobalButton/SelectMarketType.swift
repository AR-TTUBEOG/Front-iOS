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
}

struct SelectMarketType: View {
    
    let marketType: MarketTypeName
    @State var isSelected: Bool = false
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
        }, label: {
            groupView
            .frame(maxWidth: 75, maxHeight: 32)
            .background(isSelected ? Color(red: 0.63, green: 0.62, blue: 0.95).opacity(0.60) : Color(red: 0.92, green: 0.90, blue: 0.97))
            .clipShape(.rect(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.63, green: 0.62, blue: 0.95), lineWidth: isSelected ? 0.6 : 0.5)
            )
        })
        
    }
    
    private var groupView: some View {
        HStack(spacing: 2) {
            (isSelected ? selectedMarketTypeImage(type: marketType) : notSelectedMarketTypeImage(type: marketType))
                .resizable()
                .frame(maxWidth: 10, maxHeight: 17)
                .aspectRatio(contentMode: .fill)
            
            Text(marketTypeName(type: marketType))
                .font(.sandol(type: .regular, size: 14))
                .foregroundStyle(isSelected ? Color.white : Color.primary03)
                .frame(maxWidth: 37, maxHeight: 20, alignment: .bottom)
        }
    }
    
    private func marketTypeName(type: MarketTypeName) -> String {
        switch type {
        case .restaurant:
            return "음식점"
        case .cafe:
            return "카페"
        }
    }
    
    private func selectedMarketTypeImage(type: MarketTypeName) -> Image {
        switch type {
        case .restaurant:
            return Icon.whiteRest.image
        case .cafe:
            return Icon.whiteDrink.image
        }
    }
    
    private func notSelectedMarketTypeImage(type: MarketTypeName) -> Image {
        switch type {
        case .restaurant:
            return Icon.restaurant.image
        case .cafe:
            return Icon.drink.image
        }
    }
}


struct SelectMarketType_Preview: PreviewProvider {
    static var previews: some View {
        SelectMarketType(marketType: .cafe, isSelected: false)
    }
}
