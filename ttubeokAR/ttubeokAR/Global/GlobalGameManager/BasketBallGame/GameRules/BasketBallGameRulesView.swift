//
//  GameRoules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import SwiftUI

struct BasketBallGameRulesView: View {
    //MARK: - Property
    @ObservedObject var viewmodel: BasketBallGameViewModel
    
    //MARK: - Body
    var body: some View {
        settingGameRules
    }
    
    //MARK: - BasketBallGameRulesView
    private var topTitle: some View {
        Text("게임 규칙")
            .frame(maxWidth: 78, maxHeight: 30)
            .font(.sandol(type: .semiBold, size: 14))
            .background(Color(red: 0.52, green: 0.54, blue: 0.92).opacity(0.20))
            .roundedCorner(19, corners: [.topLeft, .topRight])
            .foregroundStyle(Color.white)
            .overlay(
                Rectangle()
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.52, green: 0.54, blue: 0.92), lineWidth: 0.50)
                    .roundedCorner(19, corners: [.topLeft, .topRight])
            )
            
    }
    
    private var settingGameRules: some View {
        VStack(alignment: .center, spacing: 8) {
            makeText(with: "제한시간", left: {print("-") }, time: "30초", right: {print("+")})
            Divider()
                .background(Color(red: 0.63, green: 0.62, blue: 0.95))
                .frame(maxHeight: 0.5)
            makeText(with: "공 개수", left: {print("-") }, time: "30초", right: {print("+")})
            Divider()
                .background(Color(red: 0.63, green: 0.62, blue: 0.95))
                .frame(maxHeight: 0.5)
            makeText(with: "성공 개수", left: {print("-") }, time: "30초", right: {print("+")})
        }
        .frame(maxWidth: 228, maxHeight: 143, alignment: .center)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 19))
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .inset(by: 0.5)
                .stroke(Color.primary03, lineWidth: 0.5)
        )
    }
    
    private func makeText(with text: String, left minusBtn: @escaping () -> Void, time timeText: String ,right plustBtn: @escaping () -> Void) -> some View {
        HStack(spacing: 35) {
            Text(text)
                .font(.sandol(type: .regular, size: 12))
                .frame(maxWidth: 58, maxHeight: 16, alignment: .center)
                .foregroundStyle(Color.textPink)
            
            HStack(spacing: 2) {
                Button(action: {
                    minusBtn()
                }, label: {
                    Image(systemName: "minus")
                        .frame(maxWidth: 25, maxHeight: 25)
                        .foregroundStyle(Color.white)
                        .background(Color.primary03)
                        .clipShape(Circle())
                })
                
                
                Text("\(timeText)")
                    .frame(maxWidth: 70, maxHeight: 25)
                    .font(.sandol(type: .regular, size: 12))
                    .foregroundStyle(Color.textPink)
                    
                
                
                Button(action: {
                    minusBtn()
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: 25, maxHeight: 25)
                        .foregroundStyle(Color.white)
                        .background(Color.primary03)
                        .clipShape(Circle())
                })
                
            }
            .frame(maxWidth: 110, maxHeight: 33)
        }
        .frame(maxWidth: 192, maxHeight: 33)
    }
    
}

#Preview {
    BasketBallGameRulesView(viewmodel: BasketBallGameViewModel())
        .previewLayout(.sizeThatFits)
}
