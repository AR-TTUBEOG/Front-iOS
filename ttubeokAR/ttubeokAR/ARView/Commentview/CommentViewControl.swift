//
//  CommentViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/9/24.
//

import Foundation
import SwiftUI

struct CommentViewControl : View {
    // MARK: - Property
    @StateObject var viewModel = CommentViewModel()
    
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment:.top){
            VStack(alignment: .trailing, spacing: 18){
                topBar
                textFieldView
                bottomBar
            }
        }
        .frame(maxWidth: 321, maxHeight: 349)
        .background(Color.black.opacity(0.70))
        .clipShape(.rect(cornerRadius: 25))
    }
    
    
    // MARK: - CommentView
    // MARK: - 상단바 : 댓글 아이콘, 댓글 텍스트, 취소 버튼
    private var topBar : some View{
        HStack(spacing:75){
            HStack(spacing:10){
                Icon.CommentIcon.image
                    .resizable()
                    .frame(maxWidth: 25, maxHeight: 25)
                Text("댓글")
                    .frame(maxWidth: 60, maxHeight: 22, alignment: .top)
                    .multilineTextAlignment(.center)
                    .font(.sandol(type: .bold, size: 20))
                    .lineSpacing(26)
                    .foregroundColor(.white)
                    .padding(.all, 1)
            }
            .frame(minWidth: 78, maxWidth: 25)
            //닫힘 버튼
            Button(action: {
                //TODO: - 닫힘 버튼 눌렸을 시 구현
                print("닫힘 버튼이 눌렸습니다.")
            }){
                Icon.closeIcon.image
                    .frame(maxWidth: 20, maxHeight:20)
            }
        }
        .frame(maxWidth: 173, maxHeight: 25)
        .padding(.trailing, 10)
    }
    
    /// 댓글을 작성하는 텍스트 필드
    private var textFieldView: some View {
        ZStack(alignment: .bottomTrailing) {
            CustomTextField(text: $viewModel.commentText,
                            placeholder: "남기고 싶은 댓글을 남겨주세요.",
                            fontSize: 16,
                            cornerSize: 25,
                            leadingHorizontalPadding: 29,
                            trailingHorizontalPadding: 29,
                            verticalPadding: 19,
                            maxWidth: 240,
                            maxHeight: 190,
                            onSearch: {},
                            alignment: .topLeading,
                            axis: .vertical,
                            maxLength: 60,
                            backgroundColor: Color(red: 1, green: 1, blue: 1).opacity(0.20),
                            fontColor: .white,
                            lineWidth: 0)
            Text("\(viewModel.commentText.count) / 60")
                .frame(maxWidth: 45, maxHeight: 20, alignment: .leading)
                .font(.sandol(type: .regular, size: 14))
                .multilineTextAlignment(.leading)
                .padding([.vertical, .horizontal], 15)
                .foregroundColor(Color(red: 0.92, green: 0.90, blue: 0.97))
        }
    }
    
    //MARK: - 하단 바 취소,남기기 버튼
    private var bottomBar : some View {
        HStack(spacing:15){
            cancel
            recording
        }
        .frame(width: 295, alignment: .center)
    }
    
    
    //취소 버튼
    private var cancel : some View {
        Button(action: {
            //TODO: - 취소 버튼 눌렸을 시 구현
            print("취소 버튼이 눌렸습니다.")
        }){
            Text("취소")
                .frame(maxWidth: 128, maxHeight: 39)
                .background(Color.btnBackground.opacity(0.90))
                .font(.sandol(type: .regular, size: 15))
                .foregroundStyle(.white)
                .lineSpacing(26)
                .clipShape(.rect(cornerRadius: 25))
                .multilineTextAlignment(.center)
        }
    }

    
    // 남기기 버튼
    private var recording : some View {
        Button(action: {
            //TODO: - 기록하기 버튼 눌렸을 시 api 임시 데이터 바꾸기
            viewModel.fetchCreateComment(content: "", latitude: 1.2, longitude: 1.5)
        }){
            Text("남기기")
                .frame(maxWidth: 128, maxHeight: 39)
                .background(Color.primary01)
                .font(.sandol(type: .regular, size:15))
                .foregroundColor(.white)
                .lineSpacing(26)
                .clipShape(.rect(cornerRadius: 25))
                .multilineTextAlignment(.center)
        }
    }
}


// MARK: - Preview
struct CommentViewControl_Previews: PreviewProvider {
    static var previews: some View {
        CommentViewControl()
            .previewLayout(.sizeThatFits)
    }
}
