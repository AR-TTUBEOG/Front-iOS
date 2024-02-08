//
//  BookMarkViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/6/24.
//

import SwiftUI
import Foundation

struct GuestBookView: View {
    // MARK: - Property
    @StateObject var viewModel = BookMarkViewModel()

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .trailing, spacing: 25){
                topBar
                VStack(alignment: .trailing , spacing: 25){
                    VStack(alignment: .leading, spacing : 36){
                        GuestBookImage
                        textFieldView
                    }
                    stars
                    bottomBar
                }
            }
        }
        .frame(maxWidth: 321, maxHeight: 529)
        .background(Color.black.opacity(0.70))
        .clipShape(.rect(cornerRadius: 25))
    }
    
    
    
    // MARK: - 상단바 : 방명록 아이콘, 방명록 텍스트, 취소 버튼
    private var topBar : some View {
        HStack(spacing: 68){
            HStack(spacing:4){
                Icon.notepad.image
                    .frame(maxWidth: 23, maxHeight: 23)
                Text("방명록")
                    .frame(maxWidth: 60, maxHeight: 22, alignment: .top)
                    .multilineTextAlignment(.center)
                    .font(.sandol(type: .bold, size: 20))
                    .lineSpacing(26)
                    .foregroundColor(.white)
                    .padding(.all, 1)
            }
            .frame(maxWidth: 150, maxHeight: 23)
            //close 버튼
            Button(action: {
                //TODO: - 닫힘 버튼 눌렸을 시 구현
                print("닫힘 버튼이 눌렸습니다.")
            }){
                Icon.closeIcon.image
                    .frame(maxWidth: 20, maxHeight:20)
            }
            
        }
        .frame(maxWidth: 186, maxHeight: 23, alignment: .topTrailing)
        
    }
    
    ///플러스 버튼 선택시 이미지 설정
    private var GuestBookImage : some View{
        Button(action: {
            viewModel.showImagePicker()
        }){
            if viewModel.bookMarkimages == nil {
                RoundedRectangle(cornerRadius: 21)
                    .frame(maxWidth: 99, maxHeight:97)
                    .foregroundStyle(Color(red: 0.24, green: 0.23, blue: 0.32))
                    .overlay(
                        Image("ImagePlus")
                            .resizable()
                            .frame(maxWidth:99, maxHeight:97)
                    )
            } else if (viewModel.bookMarkimages != nil) {
                Image(uiImage: viewModel.bookMarkimages!)
                    .resizable()
                    .frame(maxWidth:99, maxHeight:97)
                    .clipShape(.rect(cornerRadius: 21))
            }
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented, content: {
            BookMarkImageAdd(imageHandler: viewModel)
        })
        
    }
    
    /// 방명록을 작성하는 텍스트 필드
    private var textFieldView: some View {
        ZStack(alignment: .bottomTrailing) {
            CustomTextField(text: $viewModel.contentText,
                            placeholder: "방명록을 남겨주세요.",
                            fontSize: 14,
                            cornerSize: 25,
                            leadingHorizontalPadding: 29,
                            trailingHorizontalPadding: 29,
                            verticalPadding: 13,
                            maxWidth: 283,
                            maxHeight: 204,
                            onSearch: {},
                            alignment: .topLeading,
                            axis: .vertical,
                            maxLength: 60,
                            backgroundColor: Color(red: 1, green: 1, blue: 1).opacity(0.20),
                            fontColor: .white,
                            lineWidth: 0)
            Text("\(viewModel.contentText.count) / 60")
                .frame(maxWidth: 45, maxHeight: 20, alignment: .leading)
                .font(.sandol(type: .regular, size: 14))
                .multilineTextAlignment(.leading)
                .padding([.vertical, .horizontal], 15)
                .foregroundColor(Color(red: 0.92, green: 0.90, blue: 0.97))
        }
    }
    
    /// 별점에 따라서 별 이미지를 표시해주는 함수
    ///StarFilled - 별점 점수에 따른 채워진 별
    ///emptyStar - 별점 점수가 없을 시 비워진 별
    private var stars: some View {
        HStack(spacing: 8) {
            ForEach(0..<5, id: \.self) { index in
                if index < viewModel.filledStarCount {
                    Icon.StarFilled.image
                        .frame(maxWidth: 25, maxHeight: 25)
                        .onTapGesture {
                            viewModel.filledStarCount = index + 1
                        }
                } else {
                    Icon.emptyStar.image
                        .frame(maxWidth: 25, maxHeight: 25)
                        .onTapGesture {
                            viewModel.filledStarCount = index + 1
                        }
                }
            }
        }
        .frame(maxWidth: 153, maxHeight: 23)
    }

    
    
    //MARK: - 하단 바 취소,남기기 버튼
    private var bottomBar : some View {
        HStack(spacing:15){
            cancel
            recording
        }
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
            viewModel.createBookMark(id: 1, memberId: 2, content: "Example content", star:3, image: "example.jpg")
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
struct GuestBookView_Previews: PreviewProvider {
    static var previews: some View {
        GuestBookView(viewModel: BookMarkViewModel())
            .previewLayout(.sizeThatFits)
    }
}
