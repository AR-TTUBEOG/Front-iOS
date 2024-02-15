//
//  DeleteAccountViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/16/24.
//

import Foundation
import SwiftUI


struct DeleteAccountView: View {
    @State var isChecked: Bool = false
    @State var deletePopup: Bool = false
//    @Environment (\.dismiss) var dismiss
    
    @StateObject var viewModel = DeleteAcountViewModel()
    
    var term: String = "• 회원 탈퇴 시 등록된 모든 장소는 삭제됩니다.\n  다만 매장에 등록된 쿠폰을 받아간 사용자가 있을경우 쿠폰이 만료될때가지 탈퇴가 불가합니다.\n• 현재 계정으로 등록된 방명록과 댓글은 모두 삭제 처리됩니다.\n• 탈퇴 이후에 등록된 데이터는 복구가 불가합니다."

    
    var body: some View{
        ZStack {
            allView
                .navigationBarBackButtonHidden(true)
            
            if deletePopup {
                //검은색 배경화면 코드 넣기
                DeletePopup(deletePopup: $deletePopup)
            }
            //        if deletePopup {
            //            DeleteAccountView(isChecked: viewModel.$isChecked, deletePopup: $isChecked)
            //        }
        }
    }
    
    private var allView : some View {
        GeometryReader { geometry in
            ZStack(alignment: .top){
                explainView(geometry: geometry)
            }
        }
    }
//    
//    private var beforeViewBtn: some View {
//        Button(action: {
//            dismiss()
//        }, label:
//                
//        )
//    }
    
    private func explainView(geometry: GeometryProxy) -> some View {
         VStack {
             VStack(alignment: .leading, spacing: 50){
//                NavigationBar(isDisplayLeadingBtn: true, title: "회원 탈퇴")
                
                Text(term)
                    .frame(maxWidth: 360, maxHeight: 260)
                    .background(Color.stroke)
                    .font(.sandol(type: .medium, size: 15))
                    .foregroundColor(Color.textPink)
                    .lineSpacing(25)
                    .tracking(0.14)
                    .clipShape(.rect(cornerRadius: 24))
                    .multilineTextAlignment(.leading)
                checkBox
                    .frame(maxWidth: 260, maxHeight: 36,alignment: .leading)
            }
            .frame(maxWidth: 321)
            Spacer()
            
            exitBtn(isChecked: $isChecked)
                .padding(.bottom, 20)
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        .background(Color.background)
    }
    
    
    private var checkBox : some View {
            HStack {
                Button {
                    isChecked.toggle()
                } label: {
                    Image(isChecked ? .checkboxFilledPurple : .checkbox)
                }
                
                Text("주의사항을 모두 확인하였습니다.")
                    .foregroundStyle(.white)
                    .font(.sandol(type: .medium, size: 16))
            }
    }
    
    private func exitBtn(isChecked: Binding<Bool>) -> some View {
        Button(action: {
             deletePopup = true
        }) {
            Text("탈퇴하기")
                .frame(maxWidth: 326, maxHeight: 45)
                .background(Color.primary02)
                .font(.sandol(type: .medium, size: 20))
                .foregroundColor(.white)
                .lineSpacing(26)
                .clipShape(.rect(cornerRadius: 19))
        }
    }
    
}


struct DeleteAcountView_Previes: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
