//
//  GuestBookCard.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import SwiftUI

struct GuestBookCard : View {
    
    // MARK: - Property
    @State var guestBook: GuestBookModel
    
    // MARK: - Body
    
    
    var body: some View {
        
        VStack(spacing:0) {
            ZStack {
                backGround
                placeImage
                HStack {
                    Name
                    Setting
                }
                contents
                stars
                    .offset(x:0, y:65)
            }
        }
    }
    
    
    
    // MARK: - SpaceCard View
    
    private var backGround: some View {
        RoundedRectangle(cornerRadius: 24)
            .frame(width: 135, height: 180)
            .foregroundColor(Color(red: 160 / 255.0, green: 158 / 255.0, blue: 241 / 255.0, opacity: 0.30))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color.primary01, lineWidth: 1)
                    .cornerRadius(24) // 테두리도 동그랗게 설정
            )
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }
        
    private var placeImage: some View {
        Image(guestBook.image)
            .offset(x:0, y:-55)
            .frame(width: 103, height: 108)
    }
    
    private var Name : some View{
        Text(guestBook.userName)
            .offset(x:0, y:11)
            .font(.system(size: 11, weight: .medium))
            .foregroundColor(Color.white)
        
    }
    
    private var Setting : some View{
        Button(action: {
            print("설정 버튼 탭됨")
        }) {
            Icon.Setting.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 3, height: 10)
                .padding(.top,10)
                .offset(x:25,y:7)
        }
    }
    
    private var contents : some View{
        Text(guestBook.content)
            .offset(x:0, y:38)
            .font(.system(size:11, weight: .medium))
            .foregroundColor(Color.white)
    }
    
    private var stars: some View {
        HStack(spacing: 0) {
            let starCount = Int(guestBook.stars) ?? 0
            ForEach(0..<starCount, id: \.self) { _ in
                Icon.star2.image
                        }
        }
    }
    
    
}
// MARK: - Preview
#if DEBUG
struct GuestBookCard_reviews: PreviewProvider {
    static var previews: some View {
        // 예시 데이터 생성
        let sampleReview = GuestBookModel(
            guestbookId: 1,
            storeId: 1,
            userId: 1,
            content: "오늘도 즐거운 산책~!",
            stars: "5",
            image: "DetailViewtest",
            userName: "메타몽"
        )


        GuestBookCard(guestBook: sampleReview)
            .previewLayout(.sizeThatFits)
    }
}
#endif
