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
    @ObservedObject var bookMark = BookMarkViewModel()
    @Environment (\.dismiss) var dissmiss
    
    
    // MARK: - Body
    var body: some View {
        allView
            .onReceive(BaseLocationManager.shared.$currentLocation) { _ in
                viewModel.typeDistanceAndTime()
            }
            .navigationBarBackButtonHidden(true)
    }
    
    private var allView: some View {
        
        ZStack(alignment: .top) {
            Color.background.ignoresSafeArea()
            VStack(alignment: .center, spacing: 18) {
                topImageAndBookmarked
                    VStack(alignment: .leading, spacing: 9) {
                        groupSpaceNameButton
                        HStack {
                            leftVStack
                            count
                        }
                }
                    .padding([.leading, .trailing], 20)
                
//                    guestBookGrid
            }
        }
    }
    
    //MARK: - 장소 사진 및 찜하기
    
    /// 장소  사진  및 찜하기 버튼
    private var topImageAndBookmarked: some View {
        ZStack(alignment: .topLeading) {
//            spaceImage
            topHStack
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
    }

    
//    //MARK: - 장소 사진 설정
//    //장소 사진
//    private var spaceImage: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            
//            if let walkwayImages = viewModel.walkwayImageModel?.information {
//                    loadImage(urlString: walkwayImages.image)
//                }
//            
//            if let storeImages = viewModel.storeImageModel?.information {
//                    loadImage(urlString: storeImages.image)
//                }
//            }
//        .frame(width: 410, height: 252)
//    }
    
    @ViewBuilder
    private func loadImage(urlString: String) -> some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 410, height: 252)
            case .failure(let error):
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    
    
    private var topHStack: some View {
        HStack {
            beforView
                .padding(.bottom, 5)
            Spacer()
            spaceLiked
            .padding(.horizontal, 5)
            .padding(.top, 10)
        }
        .padding(.leading, 10)
        .frame(width: 300)
    }
    
    private var beforView: some View {
        Button(action: {
            dissmiss()
        }, label: {
            Icon.chevronLeft.image
                .resizable()
                .frame(maxWidth: 15, maxHeight: 25)
                .aspectRatio(contentMode: .fit)
        })
    }
    
    //MARK: - 장소 좋아요 버튼
    private var spaceLiked: some View {
        Button(action: {
            viewModel.toggleFavorite()
        }) {
            Image(viewModel.favoriteImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 40, maxHeight: 40)
        }
    }

    
    
    
    //MARK: - 장소이름 및 방명록 버튼
    
    private var groupSpaceNameButton: some View {
        HStack(alignment: .center, spacing: 25) {
            spaceName
            Spacer()
            HStack(alignment: .center, spacing: 10) {
                guestVisitBook
                guestBook
            }
        }
    }
    
    //장소 이름
    private var spaceName : some View {
        Text(viewModel.title)
            .foregroundStyle(Color.textPink)
            .font(.sandol(type: .bold, size: 18))
            .multilineTextAlignment(.center)
            .kerning(0.9)
            .frame(maxHeight: 24, alignment: .center)
            .padding(.leading, 10)
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

    private var leftVStack: some View {
        VStack(alignment: .leading, spacing: 2) {
            eventImage
            spaceInfomation
            groupCount
        }
    }
    
    //MARK: - 아이템 아이콘 정의
    
    //아이템들
    private var eventImage: some View {
        HStack(alignment: .center, spacing: 13) {
            viewModel.saleBenefit
                .resizable()
                .frame(maxWidth: 15, maxHeight: 18)
            
            viewModel.plusBenefit
                .resizable()
                .frame(maxWidth: 20, maxHeight: 16)
            
            viewModel.gitBeneft
                .resizable()
                .frame(maxWidth: 21, maxHeight: 18)
        }
        .padding(.horizontal, 2)
        .frame(maxWidth: 100, maxHeight: 30, alignment: .center)
    }
    
    
    //MARK: - 장소 정보(설명, 시간, 거리)
    
    /// 장소 설명 글
    private var spaceInfomation : some View{
        
        let name = viewModel.walkwayDetailDataModel?.information.name ?? viewModel.storeDetailDataModel?.information.name ?? "Default"
        
        return Text(name)
            .font(.sandol(type: .regular, size: 12))
            .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
            .multilineTextAlignment(.leading)
            .lineSpacing(1)
            .frame(maxWidth: 320, maxHeight: 47, alignment: .leading)
            .padding(.leading, 10)
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
            }
                
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
        .padding(.leading, 10)
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
    
//        //MARK: - 스크롤 방명록 보기
//        private var guestBookGrid: some View {
//            ScrollView(.vertical, showsIndicators: false) {
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: 10), GridItem(.flexible(minimum: 150), spacing: 100)], spacing: 13) {
//                    ForEach(viewModel.guestBookModel?.information ?? [], id: \.self) { information in
//                        GuestBookCard(guestBookModelInfor: information)
//                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
//                        }
//                    .frame(maxWidth: 300, maxHeight: .infinity, alignment: .center)
//                    }
//                }
//            }
//            
}


struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        DetailViewControl(viewModel: DetailViewModel())
    }
}
