//
//  PlaceSettingView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/14/24.
//

import SwiftUI

struct PlaceSettingView: View {
    @ObservedObject var viewModel = PlaceSettingsViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top){
            Color.background.ignoresSafeArea(.all)
            topall
                .offset(y: 10)
        }
        .frame(maxHeight: 400)
    }

    private var topall: some View {
        ZStack(alignment: .top) {
            
            VStack{
                
                VStack(alignment: .center, spacing: 10){
                    topRectangle
                    title
                }
                
                Spacer().frame(height: 23)
                
                VStack(alignment: .center, spacing: 60) {
                    placeSelectButton
                    sliderDistance
                    finishSelect
                }
            }
            .padding(.horizontal, 30)
        }
    }

    
    private var placeSetting: some View {
        VStack(alignment: .center, spacing: 60) {
            placeSelectButton
            sliderDistance
            finishSelect
        }
        .padding(.horizontal, 0)
        .padding(.top, 12)
    }
    
    private var topRectangle: some View {
        Rectangle()
            .foregroundStyle(Color.clear)
            .frame(maxWidth: 72, maxHeight: 6)
            .background(Color(red: 0.92, green: 0.9, blue: 0.97).opacity(0.3))
            .clipShape(.rect(cornerRadius: 20))
    }
    
    
    private var title: some View {
        Text("설정")
            .font(.sandol(type: .medium, size: 25))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
            .frame(maxWidth: .infinity, alignment: .top)
    }
    
    
    /// 장소 단일선택 버튼
    private var placeSelectButton: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("장소설정")
                .font(.sandol(type: .medium, size: 20))
                .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                .frame(maxWidth: 335, alignment: .topLeading)
            
            HStack(alignment: .center, spacing: 7) {
                ForEach(PlaceType.allCases, id: \.self) { place in
                    Button(place.rawValue) {
                        viewModel.updateSelectionPlace(place)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(viewModel.settings.selectionPlace == place ? Color.primary01 : Color.clear)
                    .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                    .multilineTextAlignment(.center)
                    .font(.sandol(type: .medium, size: 12))
                    .clipShape(.rect(cornerRadius: 16))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.5)
                            .stroke(Color.primary01, lineWidth: 1)
                    }
                }
            }
            
            
            
        }
        .padding(.leading, 0)
        .padding(.trailing, 8)
        .padding(.vertical, 0)
        .frame(maxWidth: .infinity)
    }
    
    private var sliderDistance: some View {
        VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center) {
                    Text("거리")
                        .font(.sandol(type: .medium, size: 20))
                        .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                    Spacer()
                    
                    Text("\(viewModel.distanceDisplay)")
                        .font(.sandol(type: .medium, size: 12))
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97).opacity(0.5))
                }   
                .padding(.horizontal, 16)
                
                CustomSlider(value: $viewModel.settings.distance, range: 0...10)
            }
            .padding(.vertical, 3)
            .padding(.leading, 0)
            .frame(maxWidth: .infinity)
        }

    private var finishSelect: some View {
        ZStack(alignment: .center){
            HStack{
                Button(action: {
                    print("hello")
                }) {
                    Text("설정 완료")
                        .font(.sandol(type: .medium, size: 14))
                        .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                        .frame(maxWidth: 343, maxHeight: 39.53)
                        .contentShape(Rectangle())
                        .background(Color.primary03)
                        .clipShape(.rect(cornerRadius: 20))
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PlaceSettingView()
}
