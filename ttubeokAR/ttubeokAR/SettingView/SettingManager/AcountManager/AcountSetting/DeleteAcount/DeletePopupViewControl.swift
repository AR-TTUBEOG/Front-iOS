//
//  DeletePopupViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/16/24.
//

import Foundation
import SwiftUI


struct DeletePopup: View {
    // MARK: - Property
    @StateObject var viewModel = NameChangeViewModel()
    @Binding var deletePopup: Bool
    
    var title = "닉네임을 변경하겠습니까?"
    var subtitle = "닉네임 변경은 1회만 가능합니다. 또한 기존에 등록된 방명록이나 댓글의 모든 닉네임이 변경됩니다. 변경하시겠습니까?"
    
    
    // MARK: - Body
    var body: some View {
        allView
    }
    
    private var allView : some View{
        ZStack(alignment: .top){
            VStack(spacing : 30){
                Text("탈퇴하시겠습니까?")
                bottomBar
            }
            .frame(maxWidth: 337,maxHeight: 160)
            .background(Color.btnBackground)
            .font(.sandol(type: .bold, size: 20))
            .foregroundStyle(Color.textPink)
            .clipShape(.rect(cornerRadius: 24))
                
        }
        
    }
    
    private var bottomBar : some View{
        HStack(spacing: 10){
            cancel
            delete
        }
    }
    
    private var cancel : some View {
        ZStack{
            Button {
                deletePopup = false
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
    private var delete : some View {
        ZStack{
            Button {
                deletePopup = false
            } label: {
                Text("탈퇴하기")
                    .frame(maxWidth: 139, maxHeight: 40)
                    .background(Color.primary03)
                    .font(.sandol(type: .medium, size: 20))
                    .foregroundStyle(Color.textPink)
                    .lineSpacing(26)
                    .clipShape(.rect(cornerRadius: 19))
                    .multilineTextAlignment(.center)
            }
        }
    }
        
}
    
//MARK: - Preview

struct DeletePopup_Previes: PreviewProvider {
    static var previews: some View {
        @State var isBool: Bool = false
        DeletePopup(deletePopup: $isBool)
    }
}
