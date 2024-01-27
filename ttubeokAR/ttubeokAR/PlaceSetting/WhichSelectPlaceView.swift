//
//  WhichSelectPlace.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct WhichSelectPlaceView: View {
    //MARK: - Property
    @State var path: [PlaceSelectType] = []
    
    //MARK: - Body
    var body: some View {
        NavigationStack(path: $path){
            ZStack {
                allView
            }
            .navigationDestination(for: PlaceSelectType.self) { type in
                switch type {
                case .walk:
                    WalkPlaceRegister()
                case .market:
                    MarketPlaceRegister()
                }
            }
        }
    }
    
    //MARK: - WhichSelectPlaceView
    
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                backgroundView
                blackOpacityView
                VStack(alignment: .center, spacing: 39) {
                    TitleView(
                        titleText: "어떤 장소를 \n 등록하시겠어요 ?",
                        highlightText: "등록",
                        subtitleText: nil,
                        spacing: 0)
                    .padding(.top, 94)
                    HStack(alignment: .center) {
                        PlaceSelect(type: .walk)
                        PlaceSelect(type: .market)
                    }
                }
                changeViewButton
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.95)
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
    
    /// 화면 전환 버튼
    private var changeViewButton: some View {
        HStack(alignment: .bottom, spacing: 18) {
            Button(action: {
                print("이전으로 가기")
            }) {
                Text("이전")
                    .font(.sandol(type: .medium, size: 20))
                    .foregroundColor(Color.textPink)
                    .frame(maxWidth: 154, maxHeight: 39.53)
                    .contentShape(Rectangle())
            }
            .background(Color(red: 0.25, green: 0.24, blue: 0.33))
            .clipShape(RoundedRectangle(cornerRadius: 19))
            .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
            
            Button(action: {
                print("hello")
                path.append(.walk)
            }) {
                Text("다음")
                    .font(.sandol(type: .medium, size: 20))
                    .foregroundColor(Color.textPink)
                    .frame(maxWidth: 154, maxHeight: 39.53)
                    .contentShape(Rectangle())
            }
            .background(Color.primary03)
            .clipShape(RoundedRectangle(cornerRadius: 19))
            .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
        }
        
    }
    
}

#Preview {
    WhichSelectPlaceView()
}
