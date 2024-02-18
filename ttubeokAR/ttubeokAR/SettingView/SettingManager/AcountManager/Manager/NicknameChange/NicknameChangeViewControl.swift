//
//  NicknameChangeViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/15/24.
//

import Foundation
import SwiftUI

//TODO: - 중복 검사 뷰 구현

struct NicknamePopup: View {
    // MARK: - Property
    @Binding var nicknameShowingPopup: Bool
    @Binding var accountDelete : Bool
    @StateObject var viewModel = NameChangeViewModel()
    
    
    var title = "닉네임을 변경하겠습니까?"
    var subtitle = "닉네임 변경은 1회만 가능합니다. 또한 기존에 등록된 방명록이나 댓글의 모든 닉네임이 변경됩니다. 변경하시겠습니까?"
    
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            AllView(geometry: geometry)
        }
        .background(Color.black.opacity(0.6)).ignoresSafeArea(.all)
    }
    
    
    //MARK: - 전체 뷰
    private func AllView(geometry: GeometryProxy) -> some View {
        ZStack(alignment: .center){
            VStack(spacing: 40){
                NicknameChange
                bottomBar
            }
        }
        .frame(maxWidth: 337, maxHeight: 376)
        .background(Color.stroke)
        .clipShape(.rect(cornerRadius: 24))
        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
    
    //MARK: - 닉네임 변경 파트
    private var NicknameChange : some View {
        VStack(spacing: 35){
            /// title 파트
            Text(title)
                .font(.sandol(type: .bold, size: 20))
                .foregroundStyle(Color.textPink)
                .frame(maxWidth: 207, maxHeight: 36)
                .lineSpacing(35.6)
            /// 닉네임 설정 텍스트 필드
            VStack(spacing: 0){
                HStack{
                    TextField(
                        "",
                        text: viewModel.$nickname,
                        prompt: Text(viewModel.getCurrentNickname()).foregroundStyle(.white)
                    )
                    .frame(maxHeight: 35, alignment: .center)
                    .padding(.top, 6)
                    .font(.sandol(type: .bold, size: 16))
                    .lineSpacing(35.6)
                    
                    Icon.nicknameChange.image
                        .frame(maxWidth: 32, maxHeight:30)
                }
                .frame(maxHeight: 40, alignment: .top)
                .multilineTextAlignment(.center)
                Rectangle()
                    .frame(maxWidth: 273, maxHeight: 1.5)
                    .foregroundStyle(viewModel.isValid ? .primary03 : .pointPink)
            }
            .frame(maxWidth: 273, maxHeight: 50)
            ///subtitle 설명
            Text(subtitle)
                .frame(maxWidth: 289, maxHeight:90)
                .foregroundStyle(Color.textPink)
                .font(.sandol(type: .light, size: 16))
                .lineSpacing(8)
                .tracking(0.16)
                .multilineTextAlignment(.center)
        }
    }
    
    
    //MARK: - 하단바 (취소, 변경하기 버튼)
    private var bottomBar : some View {
        HStack(spacing:10){
            cancel
            changes
        }
    }
    
    
    private var cancel : some View {
        ZStack{
            Button {
                nicknameShowingPopup = false
            } label: {
                Text("취소")
                    .frame(maxWidth: 139, maxHeight: 40)
                    .background(Color.textPink)
                    .font(.sandol(type: .medium, size: 20))
                    .foregroundStyle(Color.gradient03)
                    .lineSpacing(26)
                    .clipShape(.rect(cornerRadius: 19))
                    .multilineTextAlignment(.center)
            }
        }
    }
        
    private var changes : some View {
            ZStack{
                Button {
                    //TODO: - 변경하기 버튼 눌렀을시 액션 구현
                    print("변경하기 버튼 눌림")
                } label: {
                    Text("변경하기")
                        .frame(maxWidth: 140, maxHeight: 40)
                        .background(Color.primary03)
                        .font(.sandol(type: .medium, size: 20))
                        .foregroundStyle(.white)
                        .lineSpacing(26)
                        .clipShape(.rect(cornerRadius: 19))
                        .multilineTextAlignment(.center)
                }
            }
        }
    }


//MARK: - Preview

struct NickNamePopup_Previes: PreviewProvider {
    static var previews: some View {
        @State var isBool: Bool = false
        NicknamePopup(nicknameShowingPopup: $isBool, accountDelete: $isBool)
            .previewLayout(.sizeThatFits)
    }
}
