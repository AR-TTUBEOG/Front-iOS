//
//  WhichSelectPlace.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct WhichSelectPlaceView: View {
    //MARK: - Property
    @State private var nextView = false
    @State private var isWalkChecked = false
    @State private var isMarketChecked = false
    @Environment(\.presentationMode) var presentationMode
    var lastedSelectedTab: Int
    
    //MARK: - Body
    var body: some View {
        allView
            .navigationDestination(isPresented: $nextView) {
                if isWalkChecked {
                    WalkPlaceRegisterView(lastedSelectedTab: lastedSelectedTab)
                } else if isMarketChecked {
                    MarketPlaceRegister()
                }
            }
            .navigationBarBackButtonHidden(true)
    }
    
    //MARK: - WhichSelectPlaceView
    
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                backgroundView
                blackOpacityView
                NavigationBar(lastedSelectedTab: lastedSelectedTab)
                centerChoicePlace
                changeViewButton
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.93)
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
    
    /// 화면 가운데 표시될 뷰로써, 장소 선택 버튼이 주어진다.
    private var centerChoicePlace: some View {
        VStack(alignment: .center, spacing: 39) {
            CustomTitleView(
                titleText: "어떤 장소를 \n 등록하시겠어요 ?",
                highlightText: ["등록"],
                subtitleText: nil,
                subtitleSize: nil,
                titleWidth: 339,
                titleHeight: 79,
                subtitleWidth: nil,
                subtitleHeight: nil,
                spacing: 0,
                textAlignment: .center,
                frameAlignment: .center
            )
            .padding(.top, 94)
            HStack(alignment: .center) {
                PlaceSelect(type: .walk, isChecked: $isWalkChecked)
                PlaceSelect(type: .market, isChecked: $isMarketChecked)
            }
            .onChange(of: isWalkChecked) { oldValue, newValue in
                if newValue {
                    isMarketChecked = false
                }
            }
            .onChange(of: isMarketChecked) { oldValue, newValue in
                if newValue {
                    isWalkChecked = false
                }
            }
        }
    }
    
    /// 화면 전환 버튼
    private var changeViewButton: some View {
        HStack(alignment: .bottom, spacing: 18) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("이전")
                    .font(.sandol(type: .medium, size: 20))
                    .foregroundColor(Color.textPink)
                    .frame(maxWidth: 154, maxHeight: 42)
                    .contentShape(Rectangle())
            }
            .background(Color(red: 0.25, green: 0.24, blue: 0.33))
            .clipShape(RoundedRectangle(cornerRadius: 19))
            .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
            
            Button(action: {
                if isWalkChecked || isMarketChecked {
                    nextView = true
                }
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
    WhichSelectPlaceView(lastedSelectedTab: 1)
}
