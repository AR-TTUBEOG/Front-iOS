//
//  NicknameSettingLogin.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import SwiftUI

struct NicknameSettingLogin: View {
    @ObservedObject var viewModel: NicknameSettingViewModel
 //   @Binding var showMainView: Bool
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
            VStack(alignment: .center, spacing: 5) {
                nicknameInput
                checkingNickname
                Spacer()
                    .frame(maxHeight: 350)
                checkButton
            }
            .padding(.bottom, 20)
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
    
    private var checkButton: some View {
        Button(action: {
            if viewModel.isNicknameValid, viewModel.isNicknameAvailable == true {
                viewModel.submitNickname()
                //  showMainView = true
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
    
//struct NicknameSettingLogin_Previews: PreviewProvider {
//    static var previews: some View {
//        // 닉네임이 유효하지 않은 경우
//        NicknameSettingLogin(viewModel: NicknameSettingViewModel.previewInvalid)
//        // 닉네임이 이미 사용 중인 경우
//        NicknameSettingLogin(viewModel: NicknameSettingViewModel.previewUnavailable)
//    }
//}
//
//// 미리보기를 위한 ViewModel 확장
//extension NicknameSettingViewModel {
//    static var previewInvalid: NicknameSettingViewModel {
//        let viewModel = NicknameSettingViewModel()
//        viewModel.nickname = "A" // 유효하지 않은 닉네임 (너무 짧음)
//        viewModel.isNicknameValid = false
//        return viewModel
//    }
//
//    static var previewUnavailable: NicknameSettingViewModel {
//        let viewModel = NicknameSettingViewModel()
//        viewModel.nickname = "AlreadyTaken" // 이미 사용 중인 닉네임
//        viewModel.isNicknameAvailable = false
//        return viewModel
//    }
//}
