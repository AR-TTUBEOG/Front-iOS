//
//  PlaceRegisterFinishView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/3/24.
//

import SwiftUI

struct PlaceRegisterFinishView: View {
    
    let lastedSelectedTab: Int
    
    var body: some View {
        allView
            .navigationBarBackButtonHidden(true)
    }
    
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea(.all)
                finishTitle
                    .padding(.top, 100)
                FinishButton(lastedSelectedTab: lastedSelectedTab)
                    .position(x: geometry.size.width/2, y: geometry.size.height * 0.93)
            }
        }
    }
    
    private var finishTitle: some View {
        VStack(alignment: .center, spacing: 35) {
            Icon.placeFinish.image
                .resizable()
                .frame(maxWidth: 247, maxHeight: 90)
            CustomTitleView(titleText: "산책스팟 등록이 \n완료되었습니다 !",
                            highlightText: ["산책스팟"],
                            subtitleText: "",
                            titleWidth: 278,
                            titleHeight: 100,
                            spacing: 40,
                            textAlignment: .center,
                            frameAlignment: .center)
            
            .frame(maxWidth: 330, maxHeight: 200)
        }
        .frame(maxWidth: 278, maxHeight: 300)
    }
}

#Preview {
    PlaceRegisterFinishView(lastedSelectedTab: 1)
}
