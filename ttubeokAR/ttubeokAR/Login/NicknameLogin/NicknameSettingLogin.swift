//
//  NicknameSettingLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import SwiftUI

struct NicknameSettingLogin: View {
    @EnvironmentObject var viewModel: NicknameSettingViewModel
    @State private var showNextView = false
    
    var body: some View {
            ZStack(alignment: .center) {
                allView
            }
    }
    
    private var allView: some View {
        
        ZStack(alignment: .bottom) {
            backgroundImageView
            blackOpacity
            VStack(spacing: 299) {
                nicknameInput
                checkButton
                    .padding(.bottom, 50)
            }
        }
    }
    
    private var backgroundImageView: some View {
        Icon.nickname.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
    
    private var blackOpacity: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(Color.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.8))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    private var nicknameInput: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Name")
                .font(.sandol(type: .semiBold, size: 15))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 303, maxHeight: 39, alignment: .leading)
            
            inputNickname
        }
    }
    
    private var inputNickname: some View {
        VStack(alignment: .center, spacing: 15) {
            TextField("", text: $viewModel.nickname
                      ,prompt: Text("닉네임을 적어주세요")
                .foregroundStyle(Color.white)
                .font(.sandol(type: .light, size: 15)))
            .foregroundStyle(Color.white)
            .font(.sandol(type: .light, size: 15))
            .background(Color.clear)
            .frame(maxWidth: 303, alignment: .center)
            
            Rectangle()
                .background(Color.white)
                .frame(maxWidth: 303, maxHeight: 1)
        }
    }
    
    private var checkButton: some View {
        Button(action: {
            print("hello")
        }) {
            Text("시작하기")
                .frame(maxWidth: 305, maxHeight: 55)
                .background(Color.primary03)
                .contentShape(RoundedRectangle(cornerRadius: 19))
                .foregroundStyle(Color.white)
                .font(.sandol(type: .bold, size: 20))
                .multilineTextAlignment(.center)
                .clipShape(.rect(cornerRadius: 19))
        }
    }
}
    
    struct NicknameSettingLogin_Previews: PreviewProvider {
        static var previews: some View {
            NicknameSettingLogin()
                .environmentObject(NicknameSettingViewModel())
        }
    }
