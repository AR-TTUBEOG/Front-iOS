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
        .padding(.leading, 20)
        .frame(width: 273, height: 130, alignment: .leading)
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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                } else {
                    Circle()
                        .fill(Color(red: 0.92, green: 0.90, blue: 0.97).opacity(0.30))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .inset(by: 0.50)
                                .stroke(Color(red: 0.92, green: 0.90, blue: 0.97), lineWidth: 0.50)
                        )
                }
            })
            
            Text(title)
                .frame(width: 70, height: 20, alignment: .bottom)
                .font(.sandol(type: .bold, size: 13))
                .foregroundStyle(Color.textPink)
            
            image
                .resizable()
                .frame(width: 20, height: 20)
                .aspectRatio(contentMode: .fit)
            
        }
        .frame(width: 140, height: 25)
    }
}

struct GameCouponSelect_Preview: PreviewProvider {
    static var previews: some View {
        @State var select: Int? = 1
        GameCouponSelect(selectedBtnID: $select)
    }
}
