//
//  NicknameSettingLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import SwiftUI

/// 닉네임 중복 검사 뷰
struct NicknameSettingLogin: View {
    //MARK: - Body
    var transitionToNext: () -> Void
    @ObservedObject var viewModel: NicknameSettingViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            allView
        }
    }
    
    //MARK: - Nickname View
    /// 설정된 모든 뷰 보기
    private var allView: some View {
        
        ZStack(alignment: .center) {
            backgroundImageView
            blackOpacity
            VStack(alignment: .center) {
                nicknameInput
                    .padding(.top, 0)
                checkingNickname
                Spacer()
                    .frame(maxHeight: 270)
                checkButton
            }
            .frame(maxHeight: 500)
            .offset(y: 100)
        }
    }
    
    /// 닉네임 배경 사진
    private var backgroundImageView: some View {
        Icon.loginBackground.image
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
    
    /// 닉넨임 입력 스택
    private var nicknameInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Name")
                .font(.sandol(type: .semiBold, size: 15))
                .foregroundStyle(Color.white)
                .frame(maxWidth: 303, maxHeight: 39, alignment: .leading)
            
            inputNickname
        }
    }
    
    /// 닉네임 입렵 텍스트 필드
    private var inputNickname: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center){
                TextField("", text: $viewModel.nickname
                          ,prompt: Text("닉네임을 적어주세요")
                    .foregroundStyle(Color.white)
                    .font(.sandol(type: .light, size: 15)))
                .foregroundStyle(Color.white)
                .font(.sandol(type: .light, size: 15))
                .background(Color.clear)
                .frame(maxWidth: 230, alignment: .center)
                
                Button(action: {
                    if viewModel.isNicknameValid{
                        viewModel.checkNicknameAvailability()
                    }
                })
                {
                    Text("중복확인")
                        .font(.sandol(type: .light, size: 14))
                        .frame(maxWidth: 70, maxHeight: 24)
                        .foregroundStyle(Color.white)
                        .background((RoundedRectangle(cornerRadius: 19).fill(Color.clear)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 19)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                
            }
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: 310, maxHeight: 1)
        }
    }
    
    /// 닉네임 유효성 탈락 시 반한되는 텍스트
    private var checkingNickname: some View {
        VStack(spacing: 5) {
            if !viewModel.isNicknameValid {
                HStack(spacing: 3) {
                    Icon.warning.image
                        .resizable()
                        .frame(maxWidth: 20, maxHeight: 20)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 2)
                    Text("2자 이상 ~ 10자 이하로 입력해주세요.")
                        .font(.sandol(type: .regular, size: 15))
                        .foregroundColor(Color(red: 0.95, green: 0.62, blue: 0.62))
                        .frame(maxWidth: 285, maxHeight: 30, alignment: .leading)
                }
            }
            if let isAvailable = viewModel.isNicknameAvailable, !isAvailable {
                HStack(spacing: 3) {
                    Icon.warning.image
                        .resizable()
                        .frame(maxWidth: 20, maxHeight: 20)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 2)
                    Text("이미 사용중인 닉네임입니다.")
                        .font(.sandol(type: .regular, size: 15))
                        .foregroundColor(Color(red: 0.95, green: 0.62, blue: 0.62))
                        .frame(maxWidth: 285, maxHeight: 30, alignment: .leading)
                }
            }
        }
    }
    
    /// 닉네임 중복성 검사 버튼
    private var checkButton: some View {
        Button(action: {
            if viewModel.isNicknameValid, viewModel.isNicknameAvailable == true {
                transitionToNext()
            }
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
        NicknameSettingLogin(transitionToNext: {print("hello")}, viewModel: NicknameSettingViewModel())
    }
}
