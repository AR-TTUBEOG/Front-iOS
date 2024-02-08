//
//  PlaceSettingView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/14/24.
//

import SwiftUI

struct PlaceSettingView: View {
    
    //MARK: - Property
    @ObservedObject var viewModel = PlaceSettingsViewModel()
    //MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                topAllView
                    .position(x: geometry.size.width * 0.45, y: geometry.size.height * 0.45)
                    .padding(.horizontal, 20)
            }
            .background(Color.background.ignoresSafeArea(.all))
            .roundedCorner(40, corners: [.topLeft, .topRight])
        }
        .frame(maxHeight: 460)
    }
    
    //MARK: - PlaceSettingView
    /// 설정한 모든 뷰 Vstack으로 맞추기
    /// - Parameter geometry: 화면 사이즈에 맞추어 계산
    /// - Returns: 사이즈 조절된 뷰 리턴
    private var topAllView: some View {
        VStack(alignment: .center, spacing: 10){
            topComponent
            Spacer().frame(height: 20)
            VStack(alignment: .center, spacing: 60) {
                placeSelectButton
                sliderDistance
                finishSelect
            }
        }
        .background(Color.background.ignoresSafeArea(.all))
        .frame(maxHeight: 490)
    }
    
    private var topComponent: some View {
        VStack(spacing: 15) {
            topRectangle
            title
        }
        .offset(y: -10)
        .padding(.bottom, 15)
    }
    
    /// 상단 팝업 푸시 막대기
    private var topRectangle: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(red: 0.92, green: 0.90, blue: 0.97).opacity(0.30))
            .frame(maxWidth: 72, maxHeight: 5,alignment: .top)
    }
    
    
    /// 뷰 타이틀
    private var title: some View {
        Text("설정")
            .font(.sandol(type: .medium, size: 25))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    
    /// 장소 단일선택 버튼 타이틀
    private var placeSelectButton: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("장소설정")
                .font(.sandol(type: .medium, size: 20))
                .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            placeTypeButton
            
        }
        .padding(.leading, 16)
        .frame(height: 50)
    }
    
    /// 장소 타입 버튼 종류
    private var placeTypeButton: some View {
        HStack(alignment: .center, spacing: 7) {
            ForEach(SearchPlaceType.allCases, id: \.self) { place in
                Button(place.rawValue) {
                    viewModel.updateSelectionPlace(place)
                }
                .frame(width: 74, height: 32)
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
        .padding(.vertical, 8)
    }
    
    /// 슬라이더로 원하는 거리 값 조절
    /**
     추후 뷰 모델을 통해 조절된 값 POST하여 목록 조회
     */
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
            
            CustomSlider(value: $viewModel.distanceValue, range: 0...10)
            
        }
        .padding(.vertical, 3)
        .padding(.leading, 0)
        .frame(maxWidth: .infinity)
    }
    
    /// 완료 버튼 장소설정, 거리 조절로 통해 선택된 값 전달
    private var finishSelect: some View {
        Button(action: {
            print("hello")
        }) {
            Text("설정 완료")
                .font(.sandol(type: .medium, size: 14))
                .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                .frame(maxWidth: 360, maxHeight: 39.53)
                .contentShape(Rectangle())
                .background(Color.primary03)
                .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
    }
}

struct PlaceSettingView_Preview: PreviewProvider {
    static var previews: some View {
        PlaceSettingView(viewModel: PlaceSettingsViewModel())
            .previewLayout(.sizeThatFits)
    }
}
