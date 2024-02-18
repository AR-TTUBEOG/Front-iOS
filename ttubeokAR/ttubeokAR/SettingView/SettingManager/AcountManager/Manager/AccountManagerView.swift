//
//  AccountManagerView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/30/24.
//

/// 계정관리 뷰
import SwiftUI

struct AccountManagerView: View {
    // MARK: - Property
    @StateObject var viewModel = NameChangeViewModel()
    @StateObject var deleteViewModel =  DeleteAcountViewModel()
    @State var nicknameShowingPopup: Bool = false
    @State var accountDelete: Bool = false
    
    enum myPageType {
        case nickname
        case logout
        case accountDelete
        case socialInfo
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
                    stackButton(.nickname)
                    stackButton(.logout)
                    stackButton(.accountDelete)
                        .navigationDestination(isPresented: $accountDelete) {
                            DeleteAccountView()
                        }
                    stackButton(.socialInfo)
                }
                .frame(maxWidth: 321, maxHeight: 311)
                .padding(.top, 80)
                
                if nicknameShowingPopup {
                    NicknamePopup(nicknameShowingPopup: $nicknameShowingPopup, accountDelete: $accountDelete)
                        .animation(.easeIn(duration: 1.5), value: nicknameShowingPopup)
                }
            }
        }}
    
    // MARK: - stackButton 각 버튼 함수
    private func stackButton(_ inputType: myPageType) -> some View {
        Button(action: {
            returnAction(inputType)
        })
        {
                HStack(spacing: 10) {
                    returnImage(inputType)
                        .frame(maxWidth: 30,maxHeight: 30)
                    Text(returnText(inputType))
                        .foregroundStyle(Color.textPink)
                        .font(.sandol(type: .bold, size: 18))
                        .lineSpacing(30)
                    
                }
                .frame(maxWidth: 321, maxHeight: 67, alignment: .leading)
                .padding(.leading, 20)
                .background(Color.btnBackground)
                .clipShape(.rect(cornerRadius: 19))
        }
    }
    
    // MARK: - 이미지 함수
    private func returnImage(_ inputType: myPageType) -> Image {
        switch inputType {
        case .nickname:
            Icon.nicknameChange.image
        case .logout:
            Icon.logout.image
        case .accountDelete:
            Icon.deleteBtn.image
        case .socialInfo:
            Icon.accountBtn.image
            
        }
    }
    
    // MARK: - 버튼 텍스트 함수
    private func returnText(_ inputType: myPageType) -> String {
        switch inputType {
        case .nickname:
            return viewModel.getCurrentNickname()
        case .logout:
            return "로그아웃"
        case .accountDelete:
            return "회원 탈퇴"
        case .socialInfo:
            return "등록된 소셜 계정         |  카카오"
        }
    }
    
    // MARK: - 버튼 액션 함수
    private func returnAction(_ inputType: myPageType) -> Void {
        switch inputType {
        case .nickname:
            self.nicknameShowingPopup = true
        case .logout:
            print("로그아웃")
        case .accountDelete:
            self.accountDelete = true
        case .socialInfo:
            print("xx")
        }
    }
    
}
    
// MARK: - Preview
#Preview {
    AccountManagerView( lastedTab: 1)
}
