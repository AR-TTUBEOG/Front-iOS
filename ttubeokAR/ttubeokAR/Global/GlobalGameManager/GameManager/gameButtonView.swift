//
//  gameButtonView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/5/24.
//

import SwiftUI

struct gameButtonView: View {
    
    //MARK: - Property
    let title: String
    let gameButtonAction: () -> Void
    
    //MARK: - Body
    var body: some View {
        gameButton
    }
    
    //MARK: - gameButtonView
    
    //TODO: - 팁 버튼 추후 생성할 것
    
//    private var tipButton: some View {
//        Button(action: {}, label: {
//            Text("Tip")
//                .font(.sandol(type: .regular, size: 12))
//                .foregroundStyle(Color.white)
//                .frame(maxWidth: 45, maxHeight: 20)
//                .background(Color(red: 0.52, green: 0.54, blue: 0.92))
//                .clipShape(.rect(cornerRadius: 20))
//        })
//        .onTapGesture {
//            tipButtonAction()
//        }
//    }
    
    private var gameButton: some View {
        Button(action: gameButtonAction, label: {
            ZStack(alignment: .center) {
                HStack(spacing: 20) {
                    Text(title)
                        .font(.sandol(type: .bold, size: 15))
                        .frame(maxWidth: 80, maxHeight: 30, alignment: .center)
                        .foregroundColor(Color(red: 0.52, green: 0.54, blue: 0.92))
                }
                .frame(maxWidth: 200, maxHeight: 30)
            }
            .frame(maxWidth: 305, maxHeight: 50, alignment: .center)
            .background(Color(red: 0.88, green: 0.87, blue: 0.96))
            .clipShape(.rect(cornerRadius: 19))
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.63, green: 0.62, blue: 0.95), lineWidth: 0.50)
            )
            .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 1
            )
        })
    }
}
