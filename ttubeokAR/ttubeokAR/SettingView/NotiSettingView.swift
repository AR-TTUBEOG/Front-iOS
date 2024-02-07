//
//  NotiSetting.swift
//  ttubeokAR
//
//  Created by Subeen on 1/20/24.
//

import SwiftUI

struct NotiSettingView: View {
    
    @StateObject var settingViewModel: SettingViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                NavigationBar(isDisplayLeadingBtn: true, title: "알림")
                
                buttonList(settingViewModel: settingViewModel)
                Spacer()
            }
            
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
//                                            .padding(.top, 20)
                                            
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
    NotiSettingView(settingViewModel: SettingViewModel())
       
}
