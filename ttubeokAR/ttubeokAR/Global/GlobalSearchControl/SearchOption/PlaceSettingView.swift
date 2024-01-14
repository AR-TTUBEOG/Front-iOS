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
            placeSetting
        }
    }

    
    private var placeSetting: some  View {
        VStack(alignment: .leading, spacing: 70) {
            title
            placeSelectButton
            sliderDistance
            finishSelect
            
        }
        .padding(.horizontal, 0)
        .padding(.top, 12)
        .padding(.bottom, 174.47)
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
        VStack(alignment: .leading, spacing: 9) {
            Text("장소설정")
                .font(.sandol(type: .medium, size: 20))
                .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                .frame(width: 335, alignment: .topLeading)
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
            VStack {
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
                
                Slider(value: $viewModel.settings.distance, in: 0...10)
                  //  .background(sliderBackground())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 3)
            .padding(.leading, 0)
            .frame(maxWidth: .infinity)
        }
    
//    private func sliderBackground() -> some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Color.yellow
//                SliderLine()
//                    .stroke(Color.white, lineWidth: 1)
//                    .frame(width: geometry.size.width, height: 17)
//                ForEach([0,25,50,75,100], id: \.self) { value in
//                        Rectangle()
//                        .fill(Color.white.opacity(0.5))
//                        .frame(width: 2, height: 10)
//                }
//            }
//        }
//        .frame(width: 172, height: 17)
//    }
    
    private var finishSelect: some View {
        ZStack{
            Button(action: {
                print("hello")
            }) {
                Text("설정 완료")
                    .font(.sandol(type: .medium, size: 14))
                    .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
            }
            .frame(minWidth: 0,maxWidth: .infinity, maxHeight: 39.53)
            .background(Color.primary03)
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
}

#Preview {
    PlaceSettingView()
}
