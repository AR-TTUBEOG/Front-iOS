//
//  NicknameSettingLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import SwiftUI

/// 닉네임 중복 검사 뷰
struct NicknameSettingLogin: View {
    //MARK: - Property
    var transitionToNext: () -> Void
    @ObservedObject var viewModel: NicknameSettingViewModel
    private let keyChainManager = KeyChainManager.standard
    
    //MARK: - Body
    var body: some View {
            allView
            .onTapGesture {
                keyboardResponsive()
            }
    }
    
    //MARK: - Nickname View
    /// 설정된 모든 뷰 보기
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                backgroundImageView
                blackOpacity
                VStack(alignment: .center) {
                    VStack {
                        nicknameInput
                            .padding(.top, 0)
                        checkingNickname
                    }
                    .frame(maxHeight: 150,alignment: .top)
                    Spacer()
                        .frame(height: 260)
                    checkButton
                }
                .frame(minHeight: 500, maxHeight: 620, alignment: .bottom)
            }
            .frame(height: geometry.size.height)
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
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.8))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    /// 닉넨임 입력 스택
    private var nicknameInput: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Name")
                .font(.sandol(type: .semiBold, size: 15))
                .foregroundStyle(Color.white)
                .frame(width: 303, height: 39, alignment: .leading)
            
            inputNickname
        }
    }
    
    /// 닉네임 입렵 텍스트 필드
    private var inputNickname: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center){
                TextField("", text: $viewModel.nickname
                          ,prompt: Text("닉네임을 적어주세요")
                    .foregroundStyle(Color.white)
                    .font(.sandol(type: .light, size: 15)))
                .onChange(of: viewModel.nickname) { new, old in
                    viewModel.isNicknameAvailable = nil
                }
                .foregroundStyle(Color.white)
                .font(.sandol(type: .light, size: 15))
                .background(Color.clear)
                .frame(width: 230, height: 40, alignment: .center)
                
                Button(action: {
                    if viewModel.isNicknameValid {
                        viewModel.checkNicknameAvailability()
                    }
                })
                {
                    Text("중복확인")
                        .font(.sandol(type: .light, size: 14))
                        .frame(width: 70, height: 24)
                        .foregroundStyle(Color.white)
                        .background((RoundedRectangle(cornerRadius: 19).fill(Color.clear)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 19)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                
            }
            .frame(maxHeight: 40, alignment: .bottom)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 310, height: 1)
        }
    }
    
    /// 닉네임 유효성 탈락 시 반한되는 텍스트
    private var checkingNickname: some View {
        VStack(spacing: 5) {
            if !viewModel.isNicknameValid {
                HStack(spacing: 3) {
                    Icon.warning.image
                        .resizable()
                        .frame(width: 20, height: 20)
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
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 2)
                    Text("이미 사용중인 닉네임입니다.")
                        .font(.sandol(type: .regular, size: 15))
                        .foregroundColor(Color(red: 0.95, green: 0.62, blue: 0.62))
                        .frame(width: 285, height: 30, alignment: .leading)
                }
            }
            
            if let isAvailable = viewModel.isNicknameAvailable, isAvailable, viewModel.isNicknameValid {
                HStack(spacing: 3) {
                    Icon.nameCheck.image
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 2)
                    Text("사용 가능한 닉네임입니다.")
                        .font(.sandol(type: .regular, size: 15))
                        .foregroundColor(Color(red: 0.68, green: 1, blue: 0.65).opacity(0.80))
                        .frame(width: 285, height: 30, alignment: .leading)
                }
            }
        }
    }
    
    /// 닉네임 중복성 검사 버튼
    private var checkButton: some View {
        Button(action: {
            if viewModel.isNicknameValid, viewModel.isNicknameAvailable == true {
                viewModel.sendNickname()
                viewModel.saveNickname(newNickname: viewModel.nickname)
                transitionToNext()
            }
        }) {
            Text("시작하기")
                .frame(width: 305, height: 55)
                .background((viewModel.isNicknameValid && (viewModel.isNicknameAvailable == true)) ? Color.primary03 : Color(red: 0.25, green: 0.24, blue: 0.37))
                .contentShape(RoundedRectangle(cornerRadius: 19))
                .foregroundStyle(Color.white)
                .font(.sandol(type: .bold, size: 20))
                .multilineTextAlignment(.center)
                .clipShape(.rect(cornerRadius: 19))
                .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 4)
        }
    }
}


struct NicknameSettingLogin_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSettingLogin(transitionToNext: {print("hello")}, viewModel: NicknameSettingViewModel())
    }
}
