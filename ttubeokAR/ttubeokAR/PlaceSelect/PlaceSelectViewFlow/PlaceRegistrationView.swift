//
//  PlaceRegistration.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/26/24.
//

import SwiftUI

struct PlaceRegistrationView: View {
    
    //MARK: - Property
    var lastedSelectedTab: Int
    
    @State private var showSelectPlaceView = false
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            allView
                .navigationDestination(isPresented: $showSelectPlaceView) {
                    WhichSelectPlaceView()
                }
            //TODO: - 버튼 커스텀하여 사용하기
            /**
             루트뷰로 나가기 위해 NavigationStack으로 뷰 전환 시 생성되는 버튼 사용하지 말것!
             */
        }
    }
    
    //MARK: - PlaceRegistrationView
    
    /// 뷰 위치 배치하기
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                backgroundView
                blackOpacityView
                CloseCancelButton(lastedSelectedTab: lastedSelectedTab)
                TitleView(
                    titleText: "1분만에 장소를 \n 등록해보세요",
                    highlightText: "장소",
                    subtitleText: "장소를 등록하면 경로와 방명록을 \n 남길 수 있어요 !",
                    subtitleSize: 20,
                    titleWidth: 339,
                    titleHeight: 79,
                    subtitleWidth: 274,
                    subtitleHeight: 60,
                    spacing: 30,
                    textAlignment: .center,
                    frameAlignment: .center
                )
                .padding(.top, 94)
                nextButton
                    .position(x: geometry.size.width/2, y: geometry.size.height * 0.93)
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
            showSelectPlaceView = true
        }, label: {
            Text("장소 등록하기")
                .font(.sandol(type: .medium, size: 20))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .frame(maxWidth: 335, maxHeight: 42)
                .background((RoundedRectangle(cornerRadius: 19).fill(Color.primary03)))
        })
    }
}

struct PlaceRegistrationView_Preview: PreviewProvider {
    static var previews: some View {
        PlaceRegistrationView(lastedSelectedTab: 2)
    }
}
