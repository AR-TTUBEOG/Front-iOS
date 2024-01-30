//
//  QuitSettingView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/30/24.
//

import SwiftUI

struct QuitSettingView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                NavigationBar(isDisplayLeadingBtn: true, title: "회원 탈퇴", leadingItems: [( Icon.chevronLeft, {} )])
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    termsView()
                    
                    
                    checkBox()
                }
                .padding(.horizontal, 25)
            }
        }
    }
    
    

    private struct termsView: View {
        
        private var term: String = "- 회원 탈퇴 시 등록된 모든 장소는 삭제됩니다.\n- 현재 계정으로 등록된 방명록과 댓글도 모두 삭제 처리됩니다.\n- 탈퇴 이후에 기존 계정은 복구가 불가합니다.\n- 재가입은 72시간 이후부터 가능합니다."

        
        fileprivate var body: some View {
            RoundedRectangle(cornerRadius: 29)
                .foregroundStyle(.stroke)
                .overlay {
                    Text(term)
                        .foregroundStyle(.white)
                        .font(.sandol(type: .medium, size: 16))
                    
                }
                .frame(height: 230)
        }
    }
    
    private struct checkBox: View {
        
        @State var isChecked: Bool = false
        
        fileprivate var body: some View {
            VStack {
                HStack {
                    Button {
                        isChecked.toggle()
                    } label: {
                        Image(isChecked ? .checkboxFilledPurple : .checkbox)
                    }
                    
                    Text("주의사항을 모두 확인하였습니다.")
                        .foregroundStyle(.white)
                        .font(.sandol(type: .medium, size: 16))
                        
                    Spacer()
                }
                .padding(.top, 20)
                Spacer()
                exitBtn(isChecked: $isChecked)
            }
        }
    }
    
    private struct exitBtn: View {
        
        @Binding var isChecked: Bool
        
        fileprivate var body: some View {
            VStack {
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 19)
                        .frame(height: 40)
                        .overlay {
                            Text("탈퇴하기")
                                .foregroundStyle(.textPink)
                        }
                        .foregroundStyle(isChecked ? .primary03 : .gray)
                }
            }
            .disabled(!isChecked)
        }
    }
}

#Preview {
    QuitSettingView()
}
