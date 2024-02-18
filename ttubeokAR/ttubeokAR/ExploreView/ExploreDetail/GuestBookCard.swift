////
////  GuestBookCard.swift
////  ttubeokAR
////
////  Created by 최윤아 on 1/25/24.
////
//
//import SwiftUI
//
//struct GuestBookCard : View {
//    
//    // MARK: - Property
//    let guestBookModelInfor: GuestBookModelInfor?
//    
//    // 이미지 탭 여부 추적 변수
//    @State private var isImageTapped = false
//    
//    // MARK: - Body
//    
//    
//    var body: some View {
//        allView
//    }
//    
//    
//    
//    // MARK: - SpaceCard View
//    private var allView: some View {
//        
//        ZStack(alignment: .bottom) {
//            GeometryReader { geometry in
//                Color.clear.ignoresSafeArea(.all)
//                    .blur(radius: isImageTapped ? 20 : 0) // 이미지 탭 시 배경 흐림 효과 적용
//                backGround
//                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.83)
//                placeImage
//                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.29)
//                    .onTapGesture {
//                                       self.isImageTapped.toggle()
//                                   }
//                                   .sheet(isPresented: $isImageTapped) {
//                                       // 전체 화면으로 이미지를 보여주는 뷰
//                                       Image(guestBookModel?.image ?? "")
//                                           .resizable()
//                                           .scaledToFit()
//                                           .frame(maxWidth: 315, maxHeight: 330)
//                                   }
//                
//                placeInfor
//                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.76)
//            }
//        }
//        .frame(maxWidth: 135, maxHeight: 202)
//    }
//    
//    private var backGround: some View {
//            RoundedRectangle(cornerRadius: 24)
//                .frame(maxWidth: 135, maxHeight: 180)
//                .foregroundStyle(Color(red: 160 / 255.0, green: 158 / 255.0, blue: 241 / 255.0, opacity: 0.30))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 24)
//                        .strokeBorder(Color.primary01, lineWidth: 1)
//                )
//                .clipShape(RoundedRectangle(cornerRadius: 24))
//    }
//    
//    private var placeInfor: some View {
//        VStack(alignment: .center, spacing: 8) {
//            VStack(alignment: .trailing ,spacing: 8) {
//                HStack(alignment: .center, spacing: 28) {
//                    nickName
//                    setting
//                }
//                contentsDescript
//            }
//            stars
//        }
//    }
//        
//    private var placeImage: some View {
//        Image(GuestBookModel.image)
//            .resizable()
//            .frame(maxWidth: 103, maxHeight: 108)
//    }
//    
//    private var nickName : some View{
//        Text(guestBookModelInfor.name)
//            .font(.sandol(type: .bold, size: 11))
//            .multilineTextAlignment(.center)
//            .foregroundStyle(Color(red: 0.91, green: 0.95, blue: 1))
//            .frame(maxWidth: 34, maxHeight: 14)
//        
//    }
//    
//    private var setting : some View{
//        Button(action: {
//            print("설정 버튼 탭됨")
//        }) {
//            Icon.Setting.image
//                .resizable()
//                .frame(maxWidth: 3, maxHeight: 10)
//        }
//    }
//    
//    private var contentsDescript : some View{
//        Text(guestBookModelInfor.content)
//            .font(.sandol(type: .regular, size: 11))
//            .multilineTextAlignment(.center)
//            .foregroundStyle(Color(red: 0.91, green: 0.95, blue: 1))
//            .frame(maxWidth: 94, maxHeight: 31)
//    }
//    
//    private var stars: some View {
//        HStack(spacing: 0) {
//            let starCount = Int(guestBookModelInfor.stars) ?? 0
//            ForEach(0..<starCount, id: \.self) { _ in
//                Icon.checkStart.image
//                    .frame(maxWidth: 13, maxHeight: 12)
//            }
//        }
//    }
//}
