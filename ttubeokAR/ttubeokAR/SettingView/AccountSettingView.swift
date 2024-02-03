//
//  AccountSettingView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/30/24.
//

import SwiftUI

struct AccountSettingView: View {
    
    @State var showingPopup: Bool = false

    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                NavigationBar(isDisplayLeadingBtn: true, title: "계정관리", leadingItems: [( Icon.chevronLeft, {} )])
                nickNameBtn(showingPopup: $showingPopup)

                logoutBtn()
                deleteBtn()
                accountBtn()
                Spacer()
            }
        }
        .overlay {
            if showingPopup {
                Color.black.opacity(0.2).ignoresSafeArea(.all)
//                    .onTapGesture {
//                        showingPopup = false
//                    }
                nicknamePopup(showingPopup: $showingPopup)
            }
            
            
        }
    }
    
    private struct nickNameBtn: View {
        
        @Binding var showingPopup: Bool
        
        fileprivate var body: some View {
            Button {
                showingPopup = true
            } label : {
                RoundedRectangle(cornerRadius: 19)
                    .overlay {
                        HStack(spacing: 17) {
                            // TODO: - change assets
                            Image(systemName: "pencil")
                            Text("스티브")
                            Spacer()
                        }
                        .padding(.leading, 25)
                        .foregroundStyle(.white)
                    }
                    .foregroundStyle(Color.btnBackground)
                    .frame(height: 67)
                    .padding(.horizontal, 25)
            }
        }
    }
    
    private struct nicknamePopup: View {
        
        var title = "닉네임을 변경하겠습니까?"
        var subtitle = "닉네임 변경은 1회만 가능합니다. 또한 기존에 등록된 방명록이나 댓글의 모든 닉네임이 변경됩니다. 변경하시겠습니까?"
        
        @Binding var showingPopup: Bool
        @State var nickname: String = ""
        @State var isValid: Bool = true
        
        fileprivate var body: some View {
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(Color.stroke)
                .frame(height: 366)
                
                .overlay {
                    VStack(alignment: .center, spacing: 0) {
                        Text(title)
                            .foregroundStyle(.white)
                            .font(.sandol(type: .bold, size: 20))
                            .padding(.top, 27)
                        Spacer()
                            .frame(height: 30)
                        HStack {
                            Spacer()
                            TextField(
                                "현재 닉네임",
                                text: $nickname,
                                prompt: Text("현재 닉네임").foregroundStyle(.white)
                            )
                            .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.bottom, 7)
                        
                        Rectangle()
                            .frame(height: 1.5)
                            
                            .foregroundStyle(isValid ? .primary03 : .pointPink)
                        
                        Spacer()
                        
                        Text(subtitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        HStack(spacing: 9) {
                            Button {
                                showingPopup = false
                            } label: {
                                RoundedRectangle(cornerRadius: 19)
                                    .frame(height: 40)
                                    .overlay {
                                        Text("취소")
                                            .foregroundStyle(.primary03)
                                    }
                                    .foregroundStyle(.textPink)
                            }
                            
                            Button {
                                showingPopup = false
                            } label: {
                                 
                            }
                        }
                        .padding(.bottom, 27)
                    }
                    .padding(.horizontal, 32)
                    
                }
                .padding(.horizontal, 16)
        }
    }
    
    private struct logoutBtn: View {
        fileprivate var body: some View {
            RoundedRectangle(cornerRadius: 19)
                .overlay {
                    HStack(spacing: 17) {
                        // TODO: - change assets
                        Image(systemName: "pencil")
                        Text("로그아웃")
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .foregroundStyle(.white)
                }
                .foregroundStyle(Color.btnBackground)
                .frame(height: 67)
                .padding(.horizontal, 25)
        }
    }
    
    private struct deleteBtn: View {
        fileprivate var body: some View {
            RoundedRectangle(cornerRadius: 19)
                .overlay {
                    HStack(spacing: 17) {
                        // TODO: - change assets
                        Image(systemName: "pencil")
                        Text("회원 탈퇴")
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .foregroundStyle(.white)
                }
                .foregroundStyle(Color.btnBackground)
                .frame(height: 67)
                .padding(.horizontal, 25)
        }
    }
    
    private struct accountBtn: View {
        fileprivate var body: some View {
            RoundedRectangle(cornerRadius: 19)
                .overlay {
                    HStack(spacing: 17) {
                        // TODO: - change assets
                        Image(systemName: "pencil")
                        Text("등록된 소셜 계정")
                        Spacer()
                    }
                    .padding(.leading, 25)
                    .foregroundStyle(.white)
                }
                .foregroundStyle(Color.btnBackground)
                .frame(height: 67)
                .padding(.horizontal, 25)
        }
    }
}

#Preview {
    AccountSettingView()
}
