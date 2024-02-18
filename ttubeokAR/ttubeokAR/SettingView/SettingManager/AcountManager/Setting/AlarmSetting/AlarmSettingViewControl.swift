//
//  AlarmSettingViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/18/24.
//

import Foundation
import SwiftUI

struct AlarmSettingViewControl: View {
    
    @StateObject var settingViewModel: SettingViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                topBar
                buttonList(settingViewModel: settingViewModel)
                    .padding(.top, 20)
                Spacer()
                    
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var topBar : some View {
        HStack{
            Button(action : {
                dismiss()
            }) {
                Icon.chevronLeft.image
                    .resizable()
                    .frame(maxWidth: 11, maxHeight: 18)
                    .padding(.leading,10)
            }
            
            Spacer()
                .frame(maxWidth: 170)
            Text("알림")
                .font(.sandol(type: .bold, size: 25))
                .foregroundStyle(Color.textPink)
        }
    }
    
    private struct buttonList: View {
        @ObservedObject var settingViewModel: SettingViewModel
        
        fileprivate init(settingViewModel: SettingViewModel) {
            self.settingViewModel = settingViewModel
        }
        
        fileprivate var body: some View {
            VStack(spacing: 17) {
                ForEach(settingViewModel.options, id: \.self) { option in
                    buttonCell(option: option)
                }
            }
            .padding(.horizontal, 25)
        }
    }
    
    private struct buttonCell: View {
        
        private var option: NotiOption
        @State private var isOn: Bool
        
        init(option: NotiOption) {
            self.option = option
            self.isOn = option.isSelected
        }
        
        fileprivate var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 19)
                    .foregroundStyle(.btnBackground)
                    .frame(height: 120)
                    .overlay {
                        VStack(alignment: .leading, spacing: 0) {
                            VStack(spacing: 0) {
                                HStack(alignment: .center) {
                                        Text(option.title)
                                            .font(.sandol(type: .bold, size: 20))
                                            
                                        Spacer()
                                        Toggle("", isOn: $isOn)
                                            .toggleStyle(CustomToggle())
                                            
                                        
                                    }
                                .padding(.top, 15)
                                .padding(.horizontal, 20)
                                    Spacer()
                                
                                }
                            Text(option.description)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .font(.sandol(type: .regular, size: 12))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 20)
                            }
                            .foregroundStyle(.textPink)
                        }

                Rectangle()
                    .foregroundStyle(.textPink)
                    .opacity(0.2)
                    .frame(height: 1)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    AlarmSettingViewControl(settingViewModel: SettingViewModel())
       
}
