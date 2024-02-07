//
//  GameCouponSelect.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/7/24.
//

import SwiftUI

struct GameCouponSelect: View {
    //MARK: - Property
    @Binding var selectedBtnID: Int?
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            makeCheckBtn(name: "할인 쿠폰", img: Icon.gameCoupon.image, id: 1)
            makeCheckBtn(name: "1+1 쿠폰", img: Icon.gameOnePlus.image, id: 2)
            makeCheckBtn(name: "무료 쿠폰", img: Icon.gameBox.image, id: 3)
        }
        .padding(.horizontal, 4)
        .frame(maxWidth: 228, maxHeight: 107, alignment: .leading)
        .background(Color(red: 0.25, green: 0.24, blue: 0.37))
        .clipShape(.rect(cornerRadius: 19))
        .overlay(
            RoundedRectangle(cornerRadius: 19)
                .inset(by: 0.5)
                .stroke(Color.primary03, lineWidth: 0.5)
        )
    }
    
    //MARK: - GameCouponSelectView
    
    private func makeCheckBtn(name title: String, img image: Image, id selectID: Int ) -> some View {
        HStack(spacing: 10) {
            Button(action: {
                        // 새로운 버튼이 눌렸을 때의 로직
                        if self.selectedBtnID == selectID {
                            // 이미 선택된 버튼을 다시 누르면 선택 해제
                            self.selectedBtnID = nil
                        } else {
                            // 새로운 버튼을 선택
                            self.selectedBtnID = selectID
                        }
                    }, label: {
                if self.selectedBtnID == selectID {
                    Icon.checkCircle.image
                        .resizable()
                        .frame(maxWidth: 15, maxHeight: 15)
                        .aspectRatio(contentMode: .fill)
                    
                } else {
                    Circle()
                        .fill(Color(red: 0.92, green: 0.90, blue: 0.97).opacity(0.30))
                        .frame(maxWidth: 15, maxHeight: 15)
                        .overlay(
                            Circle()
                                .inset(by: 0.50)
                                .stroke(Color(red: 0.92, green: 0.90, blue: 0.97), lineWidth: 0.50)
                        )
                }
            })
            
            Text(title)
                .frame(maxWidth: 50, maxHeight: 18, alignment: .bottom)
                .font(.sandol(type: .bold, size: 12))
                .foregroundStyle(Color.textPink)
            
            image
                .resizable()
                .frame(maxWidth: 15, maxHeight: 15)
                .aspectRatio(contentMode: .fill)
            
        }
        .frame(maxWidth: 120, maxHeight: 18)
    }
}
