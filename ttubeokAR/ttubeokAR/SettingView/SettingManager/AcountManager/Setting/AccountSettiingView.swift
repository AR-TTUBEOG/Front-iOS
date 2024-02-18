//
//  AccountSettiingView.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/18/24.
//

import Foundation
import SwiftUI

struct AccountSettiingView: View {
    // MARK: - Property
    @State var alarmShowingPopup: Bool = false
    @State var placeSetting: Bool = false
    @StateObject var viewModel: PlaceViewModel
    
    
    enum mySettingType {
        case place
        case alarm
    }
    
    let lastedTab: Int
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea()
                //TODO: - NavigationBar 수정
                NavigationBar(title: "계정 관리", lastedSelectedTab: lastedTab)
                    VStack(spacing: 15) {
                        stackButton(.place)
                            .navigationDestination(isPresented: $placeSetting) {
//                                ManagePlaceSettingView(PlaceViewModel: PlaceViewModel())
                            }
                        stackButton(.alarm)
                            .navigationDestination(isPresented: $alarmShowingPopup) {
                                AlarmSettingViewControl(settingViewModel: SettingViewModel())
                            }
                    }
                    .frame(maxWidth: 321, maxHeight: 311)
                    .padding(.top, 80)
                    
                }
        }}

    
    // MARK: - stackButton 각 버튼 함수
    private func stackButton(_ inputType: mySettingType) -> some View {
        Button(action: {
            returnAction(inputType)
        })
        {
            HStack {
                Text(returnText(inputType))
                    .foregroundStyle(Color.textPink)
                    .font(.sandol(type: .bold, size: 18))
                    .lineSpacing(30)
                Spacer()
                Icon.chevronRight.image
            }
            .padding(.trailing, 20)
            
        }
        .frame(maxWidth: 321, maxHeight: 67, alignment: .leading)
        .padding(.leading, 20)
        .background(Color.btnBackground)
        .clipShape(.rect(cornerRadius: 19))
    }
    
    
    
    // MARK: - 버튼 텍스트 함수
    private func returnText(_ inputType: mySettingType) -> String {
        switch inputType {
        case .place:
            return "등록된 장소 관리"
        case .alarm:
            return "알림"
        }
    }
    
    // MARK: - 버튼 액션 함수
    private func returnAction(_ inputType: mySettingType) -> Void {
        switch inputType {
        case .place:
            self.placeSetting = true
        case .alarm:
            self.alarmShowingPopup = true
        }
    }
}
    
//// MARK: - Preview
//#Preview {
//    AccountSettiingView( lastedTab: 1)
//}
