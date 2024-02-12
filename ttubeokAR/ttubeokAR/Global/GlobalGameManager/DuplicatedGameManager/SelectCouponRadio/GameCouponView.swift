//
//  GameCouponView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct GameCouponView: View {
    
    @Binding var selectBtn: Int?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GameSettingSubTitle(title: "혜택 쿠폰")
                .offset(x: 13)
            GameCouponSelect(selectedBtnID: $selectBtn)
                .offset(y: 30)
        }
        .frame(maxWidth: 260, maxHeight: 170)
    }
}
