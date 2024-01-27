//
//  PlaceRegistration.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/26/24.
//

import SwiftUI

struct PlaceRegistrationView: View {
    
    //MARK: - Body
    var body: some View {
        allView
    }
    
    //MARK: - PlaceRegistrationView
    
    /// 뷰 위치 배치하기
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                backgroundView
                blackOpacityView
                TitleView(
                    titleText: "1분만에 장소를 \n 등록해보세요",
                    highlightText: "장소",
                    subtitleText: "장소를 등록하면 경로와 방명록을 \n 남길 수 있어요 !",
                    spacing: 30)
                .padding(.top, 94)
                nextButton
                    .position(x: geometry.size.width/2, y: geometry.size.height * 0.95)
            }
        }
    }
    
    /// 배경 화면 설정
    private var backgroundView: some View {
        Icon.PlaceBackground.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 375, maxHeight: .infinity)
            .ignoresSafeArea(.all)
    }
    
    /// 배경 화면 위 검은 배경
    private var blackOpacityView: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.3))
    }
    
    /// 다음 뷰로 넘어가는 버튼
    private var nextButton: some View {
        Button(action: {
            print("hello")
        }, label: {
            Text("장소 등록하기")
                .font(.sandol(type: .medium, size: 20))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .frame(maxWidth: 335, maxHeight: 55)
                .background((RoundedRectangle(cornerRadius: 19).fill(Color.primary03)))
        })
    }
}





#Preview {
    PlaceRegistrationView()
}
