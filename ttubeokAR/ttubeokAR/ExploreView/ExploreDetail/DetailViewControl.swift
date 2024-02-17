//
//  DetailViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import SwiftUI

struct DetailViewControl: View {
    // MARK: - Property
    @ObservedObject var viewModel: DetailViewModel
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea()
                VStack(alignment: .center, spacing: 18) {
                    topImageAndBookmarked
                    VStack(alignment: .leading, spacing: 9) {
                        groupSpaceNameButton
                        eventImage
                        groupspaceInfor
                        groupCount
                        
                    }
                    .frame(maxWidth: geometry.size.width * 0.9, maxHeight: 140)
                    //guestBookGrid
                }
            }
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            .onAppear{
                viewModel.locationManager.startUpdatingLocation()
            }
        }
    }
    
    //MARK: - 장소 사진 및 찜하기
    
    /// 장소  사진  및 찜하기 버튼
    private var topImageAndBookmarked: some View {
        ZStack(alignment: .topTrailing) {
//            spaceImage
            spaceLiked
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 226)
    }
    
    
    //MARK: - 장소 사진 설정
//    //장소 사진
//    private var spaceImage: some View {
//        Image(viewModel.images[viewModel.currentImageIndex])
//            .resizable()
//            .frame(maxWidth: .infinity, maxHeight: 252)
//            .aspectRatio(contentMode: .fill)
//            .gesture(
//                DragGesture()
//                    .onEnded{ value in
//                        if value.translation.width < 0 {
//                            viewModel.nextImage()
//                        } else if value.translation.width > 0 {
//                            viewModel.previousImage()
//                        }
//                    }
//            )
//    }
    
    //MARK: - 장소 좋아요 버튼
    private var spaceLiked: some View {
        Button(action: {
            viewModel.toggleFavorite()
        }) {
            Image(viewModel.favoriteImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 40, maxHeight: 40, alignment: .bottomTrailing)
        }
    }
    
    
    //MARK: - 장소이름 및 방명록 버튼
    
    private var groupSpaceNameButton: some View {
        HStack(alignment: .center, spacing: 26) {
            spaceName
            HStack(alignment: .center, spacing: 4) {
                guestVisitBook
                guestBook
            }
        }
        .frame(maxWidth: 420, alignment: .center)
    }
    
    //장소 이름
    private var spaceName : some View {
        Text(viewModel.title)
            .foregroundStyle(Color.textPink)
            .font(.sandol(type: .bold, size: 18))
            .multilineTextAlignment(.leading)
            .kerning(0.9)
            .frame(maxWidth: 280, maxHeight: 24,alignment: .leading)
    }
    
    //TODO: 방문하기 시 등장해야 할 뷰 지정하기
    
    //방문하기
    private var guestVisitBook: some View {
        Button(action: {
            print("방문")
        }) {
            Text("방문하기")
                .frame(maxWidth: 75, maxHeight: 27)
                .background(Color.white)
                .foregroundStyle(Color.primary05)
                .font(.sandol(type: .bold, size: 11))
                .kerning(0.33)
                .multilineTextAlignment(.center)
                .clipShape(.rect(cornerRadius: 19))
        }
    }
    
    //TODO: 방명록 작성 버튼 뷰 지정하기
    
    //방명록 작성
    private var guestBook: some View {
        Button(action: {
            print("방명록 작성")
        }) {
            Text("방명록 작성")
                .frame(maxWidth: 75, maxHeight: 27)
                .background(Color.primary01)
                .foregroundStyle(Color.white)
                .font(.sandol(type: .bold, size: 11))
                .kerning(0.33)
                .multilineTextAlignment(.center)
                .clipShape(.rect(cornerRadius: 19))
        }
    }
    
    //MARK: - 아이템 아이콘 정의
    
    //아이템들
    private var eventImage: some View {
        HStack(alignment: .center, spacing: 13) {
            viewModel.saleBenefit
                .resizable()
                .frame(maxWidth: 15, maxHeight: 15)
            
            viewModel.plusBenefit
                .resizable()
                .frame(maxWidth: 20, maxHeight: 15)
            
            viewModel.gitBeneft
                .resizable()
                .frame(maxWidth: 21, maxHeight: 15)
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: 100, maxHeight: 25, alignment: .center)
    }
    
    
    //MARK: - 장소 정보(설명, 시간, 거리)
    
    private var groupspaceInfor: some View {
        HStack(alignment: .center, spacing: 40) {
            spaceInfomation
            count
        }
        .frame(maxWidth: 370, maxHeight: 80)
    }
    
    /// 장소 설명 글
    private var spaceInfomation : some View{
        Text(viewModel.spaceDescript)
            .font(.sandol(type: .regular, size: 11))
            .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
            .multilineTextAlignment(.leading)
            .lineSpacing(1)
            .frame(maxWidth: 320, maxHeight: 47, alignment: .leading)
    }
    
    private var count : some View {
        VStack(alignment: .center, spacing: 2) {
            HStack(alignment: .center, spacing: 3) {
                Icon.unstar.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 13, maxHeight: 13)
                
                Text(String(viewModel.sapceStartPoint))
                    .frame(maxWidth: 42, maxHeight: 16, alignment: .leading)
                    .font(.sandol(type: .bold, size: 11))
                    .foregroundStyle(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
            }
            
            HStack(alignment: .center, spacing: 3) {
                Icon.unDistance.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 12, maxHeight: 12)
                Text(formatDistance(viewModel.distance))
                    .font(.sandol(type: .bold, size: 11))
                    .foregroundStyle(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                    .frame(maxWidth: 42, maxHeight: 16, alignment: .leading)
                
                HStack(alignment: .center, spacing: 3) {
                    Icon.unTime.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 10, maxHeight: 11)
                    
                    Text(formatEstimatedTime(viewModel.estimatedTime))
                        .font(.sandol(type: .bold, size: 11))
                        .foregroundStyle(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                        .frame(maxWidth: 42, maxHeight: 16, alignment: .leading)
                }
                
            }
        }
    }
    
    func formatDistance(_ distance: Double) -> String {
        if (distance / 1000) > 100 {
            return "99km+"
        } else {
            return String(format: "%.1f km", distance / 1000)
        }
    }
    
    func formatEstimatedTime(_ time: Double) -> String {
        let minutes = Int(round(time / 60))
        if minutes > 1000 {
            return "999+ 분"
        } else {
            return "\(minutes)분"
        }
    }
        //MARK: - 좋아요 및 방명록 수
    
        private var groupCount: some View {
            HStack(spacing: 9) {
                likesCount
                bookCount
            }
        }
    
        // 좋아요 수
        private var likesCount : some View{
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundStyle(Color.chart)
                    .clipShape(.rect(cornerRadius: 19))
                    .frame(maxWidth: 65, maxHeight: 22)
                HStack(spacing: 4) {
                    Icon.heartBold.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 15, maxHeight: 15)
                    Text(viewModel.formattedCount(viewModel.likeText))
                        .font(.sandol(type: .bold, size: 11))
                        .foregroundStyle(Color.white)
                }
            }
        }
    
        // 방명록 수
        private var bookCount : some View{
            ZStack(alignment: .center){
                Rectangle()
                    .foregroundStyle(Color.textBlue)
                    .clipShape(.rect(cornerRadius: 19))
                    .frame(maxWidth: 55, maxHeight: 22)
                HStack(spacing: 4) {
                    Icon.Subtract.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 9, maxHeight: 11)
                    Text(viewModel.formattedCount(viewModel.reviewText))
                        .font(.sandol(type: .bold, size: 11))
                        .foregroundStyle(Color(red: 36/255, green: 88/255, blue: 139/255))
                }
            }
    
        }
    
    //
    //    //MARK: - 스크롤 방명록 보기
    //    private var guestBookGrid: some View {
    //        ScrollView(.vertical, showsIndicators: false) {
    //            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: 10), GridItem(.flexible(minimum: 150), spacing: 100)], spacing: 13) {
    //                // 안전하게 옵셔널을 처리하기 위해 옵셔널 바인딩 사용
    //                if let informationList = self.viewModel.exploreDetailData?.information {
    //                    ForEach(informationList, id: \.storeId) { information in
    //                        GuestBookCard(viewModel: viewModel,GuestBookModel: GuestBookModel, StoreInformation: information)
    //                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
    //                    }
    //                }
    //            }
    //        }
    //        .frame(maxWidth: 300, maxHeight: .infinity, alignment: .center)
    //    }
    //
    //}
    //
    //
    //
    //
    //
}
