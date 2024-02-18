//
//  RegisteredPlaceCard.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/18/24.
//

import Foundation
import SwiftUI

struct RegisteredPlaceCard: View {
    
    @StateObject var viewModel: PlaceViewModel
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                VStack(alignment: .leading, spacing: 9) {
                    Image("spaceTest")
                        .resizable()
                        .frame(maxWidth: 121, maxHeight:80)
                        .clipped()
                    Text(viewModel.registeredPlaceInfor?.name ?? "")
                        .foregroundStyle(Color.textPink)
                        .font(.sandol(type: .regular, size: 14))
                        .frame(maxWidth: 90, maxHeight:18, alignment: .leading)
                    Text(viewModel.registeredPlaceInfor?.info ?? "")
                        .foregroundStyle(.textPink).opacity(0.5)
                        .font(.sandol(type: .regular, size: 11))
                        .frame(maxWidth: 115, maxHeight:28,alignment: .leading)
                }
                .frame(maxWidth: 121, maxHeight: 136)
            }
            .frame(width: 150, height: 160)
            .background(Color.primary01.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 0) 
                    .stroke(Color.primary01, lineWidth: 2) // 테두리 적용
            )
            
        }
    }
}

        
