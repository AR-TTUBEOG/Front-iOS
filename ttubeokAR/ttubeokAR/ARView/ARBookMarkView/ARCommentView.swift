//
//  ARCommentView.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/11/24.
//

import Foundation
import SwiftUI




struct ARCommentView : View{
    //MARK: - Property
    @StateObject var viewModel = BookMarkViewModel()
    
    
    //MARK: - Body
    var body: some View {
        CommentAllView
    }
    
    //MARK: - CommentView
    private var CommentAllView : some View {
        ZStack(alignment: .leading){
            HStack{
                commentImage
                userInfoLabel
            }
            .padding(.trailing,6)
        }
        .frame(maxWidth: 260, maxHeight: 100)
        .background((RoundedRectangle(cornerRadius: 22) .fill(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.52, green: 0.54, blue: 0.92),
                    Color(red: 0.40, green: 0.38, blue: 0.73),
                    Color(red: 0.38, green: 0.36, blue: 0.71),
                    Color(red: 0.25, green: 0.18, blue: 0.50)
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .opacity(0.80)
        ))
    }
    
    
    /// 댓글  이미지
    private var commentImage : some View {
        // TODO: - api 해당 이미지 연결
        Icon.ARBookMarktest.image
            .resizable()
            .frame(maxWidth:87, maxHeight:105)
            .roundedCorner(22, corners: [.topLeft, .bottomLeft])
    }
        
    
    /// 댓글  텍스트 view 부분 (사용자 이름, 내용, 일 수)
    /// TODO: - api 해당 유저 이름, 댓글 내용, 일 수 연결
    private var userInfoLabel : some View {
        VStack(alignment: .trailing){
            commentName
            VStack{
                RecoredDay
            }
            .padding(.trailing,6)
        }
        .frame(maxWidth: 159, maxHeight: 85)
    }
    
    /// 댓글  사용자 이름, 내용
    private var commentName : some View {
        VStack(alignment: .leading, spacing:0){
            // TODO: - 해당 사용자 이름 api 연결
            Text("귤의 여왕")
                .frame(maxWidth: 88, maxHeight: 29, alignment: .leading)
                .font(.sandol(type: .bold, size: 13))
                .lineSpacing(26)
                .foregroundColor(.white)
            // TODO: - 댓글 텍스트 api 연결
            Text("댓글 내용")
                .frame(maxWidth: 159, maxHeight: 30, alignment: .leading)
                .font(.sandol(type: .bold, size: 11))
                .lineSpacing(15)
                .foregroundColor(Color(red: 1, green: 1, blue: 1).opacity(0.80))
        }
        .frame(maxWidth: 159, maxHeight: 60)
    }
    
    
    ///댓글 작성 날짜 기록 일 수 (몇일 전)
    private var RecoredDay : some View {
        // TODO: - 날짜 기록 일 수 api 연결
        Text("2일 전")
            .frame(maxWidth: 30, maxHeight: 26)
            .font(.sandol(type: .bold, size: 11))
            .lineSpacing(26)
            .foregroundColor(Color(red: 1, green: 1, blue: 1).opacity(0.60))
    }
}

// MARK: - Preview
#Preview {
    ARCommentView()
}

