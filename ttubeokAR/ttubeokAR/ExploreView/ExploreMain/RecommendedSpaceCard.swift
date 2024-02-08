//
//  RecommendedSpaceCard.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import SwiftUI

struct RecommendedSpaceCard: View {
    // MARK: - Property
    @State private var isFavorited = false
    @State var placeTypeColor: Color?
    @State var baseImage: Image?
    @State var placeTypeText: Text?
    
    let viewModel: ExploreViewModel
    let exploreDataInfor: ExploreDetailInfor?
    
    
    // 장소 타입 저장할 변수 필요
    
    // MARK: - Body
    
    var body: some View {
        allView
            .frame(maxWidth: 150, maxHeight: 180)
            .padding(.top, 0)
            .background(Color.btnBackground)
            .clipShape(.rect(cornerRadius: 19))
            .shadow(radius: 5)
    }
    
    //MARK: - ViewSetting
    private var allView: some View {
        VStack(spacing:0) {
            topInfor
            spaceName
            HStack{
                bottomLeftSpaceInfo
                bottomRightSpaceInfo
            }
            .padding(.horizontal, 30)
            
            Spacer()
            Spacer()
        }
    }
    
    private var topInfor: some View {
        ZStack{
            spaceImage
            spaceLiked
                .offset(x: 52, y: -20)
        }
    }
    
    private var bottomLeftSpaceInfo: some View {
        VStack(spacing:1){
            spaceRating
            spaceDistance
            spaceTime
        }
        .offset(x: 20 , y: 0)
    }
    
    private var bottomRightSpaceInfo: some View {
        VStack(spacing: 1) {
            spaceReviewCount
                .offset(x: 56, y: -17)
            
            spaceSpotType
                .offset(x: 41, y: -15)
        }
        .offset(x: 3 , y: 20)
    }
    
    
    // MARK: - 장소 이미지 및 이름
    //장소 이미지
    private var spaceImage : some View {
        Image(self.exploreDataInfor?.image ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 150, maxHeight: 80)
        //TODO: Radius 별개로 지정할 것
        //TODO: 패딩필요하면 넣을 것
    }
    
    //장소 이름
    private var spaceName : some View {
        Text(self.exploreDataInfor?.name ?? "")
            .font(.sandol(type: .regular, size: 15))
            .foregroundColor(Color.textPink)
            .frame(maxWidth: 130, maxHeight: 19, alignment: .center)
    }
    
    //장소 좋아요
    private var spaceLiked: some View {
        Button(action: {
            changePlaceType()
            DispatchQueue.main.async {
                viewModel.isFavorited.toggle()
//                viewModel.checkLike()
            }
        }) {
            Image(viewModel.favoriteImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
        }
    }
    
    private func changePlaceType() {
        if (self.exploreDataInfor?.placeType.spot) != nil {
            viewModel.placeType = .spot
        } else if (self.exploreDataInfor?.placeType.store) != nil {
                viewModel.placeType = .store
            }
        }
        
        // MARK: - 장소 간단 정보
        // 별점
        private var spaceRating: some View {
            HStack {
                Image("starRating")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 13, maxHeight: 13)
                
                Text(String(self.exploreDataInfor?.stars ?? 0.0))
                    .frame(maxWidth: 15, maxHeight: 15)
                    .font(.sandol(type: .regular, size: 11))
                    .foregroundColor(Color.textPink)
                
            }
            .frame(maxWidth: 31, maxHeight: 16)
        }
        
        //거리
        private var spaceDistance: some View {
            HStack {
                Icon.distance.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 12, maxHeight: 12)
                Text(formatDistance(viewModel.distance))
                    .font(.sandol(type: .regular, size: 11))
                    .foregroundColor(.textPink)
                    .frame(maxWidth: 32, maxHeight: 15)
            }
            .frame(maxWidth: 46, maxHeight: 15)
        }
        
        
        func formatDistance(_ distance: Double) -> String {
            if (distance / 1000) > 100 {
                return "99km+"
            } else {
                return String(format: "%.1f km", distance / 1000)
            }
        }
        
        
        // 시간
        private var spaceTime: some View {
            HStack {
                Icon.time.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 11, maxHeight: 11)
                
                Text( formatEstimatedTime(viewModel.estimatedTime))
                    .font(.sandol(type: .regular, size: 11))
                    .foregroundColor(Color.textPink)
                    .frame(maxWidth: 32, maxHeight: 15)
            }
            .frame(maxWidth: 46, maxHeight: 15)
        }
        
        func formatEstimatedTime(_ time: Double) -> String {
            let minutes = Int(round(time / 60))
            if minutes > 1000 {
                return "999+ 분"
            } else {
                return "약 \(minutes)분"
            }
        }
        
        
        //MARK: - 방명록 수 및 타입 이미지
        
        //리뷰 개수
        private var spaceReviewCount: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .frame(maxWidth: 36, maxHeight: 13)
                    .foregroundColor(Color.textBlue)
                    .clipShape(.rect(cornerRadius: 19))
                Icon.reviewCount.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 9, maxHeight: 9)
                offset(x: 4, y: 0)
                Text(viewModel.formattedReviewCount(self.exploreDataInfor?.guestbookCount ?? 0))
                    .font(.sandol(type: .bold, size: 7))
                    .foregroundStyle(Color(red: 36 / 255, green: 88 / 255, blue: 139 / 255))
                    .offset(x:13, y:0)
            }
        }
        
        
        // 장소 유형
        private var spaceSpotType: some View {
            ZStack(alignment: .center) {
                Rectangle()
                    .frame(maxWidth: 36, maxHeight: 13)
                    .foregroundStyle(getColor(for: self.exploreDataInfor?.placeType))
                    .clipShape(.rect(cornerRadius: 19))
                Text(getPlaceTypeText(for: self.exploreDataInfor?.placeType))
                    .font(.sandol(type: .bold, size: 7))
                    .foregroundStyle(getPlaceTypeTextColor(for: self.exploreDataInfor?.placeType))
                    .offset(x: 4, y: -13)
                getImage(for: self.exploreDataInfor?.placeType)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 9, maxHeight: 9)
                    .offset(x: -10, y: -27)
            }
        }
        
        func getImage(for PlacePurpose: PlacePurpose?) -> Image {
            guard let PlacePurpose = PlacePurpose else {
                // placeType이 nil일 경우 처리
                placeTypeColor = Color.lightGreen2
                return Image("default")
            }
            if PlacePurpose.store {
                return Icon.tree.image
            } else if PlacePurpose.spot {
                return Icon.store.image
            }
            // 둘 다 아닐 시
            placeTypeColor = Color.lightGreen2
            return Image("default")
        }
        
        func getColor(for PlacePurpose: PlacePurpose?) -> Color {
            guard let PlacePurpose = PlacePurpose else {
                // placeType이 nil일 경우 처리
                return Color.lightGreen2
            }
            
            if PlacePurpose.spot {
                return Color.lightGreen2
            } else if PlacePurpose.store {
                return Color.lightOrange
            }
            return Color.lightGreen2
        }
        
        func getPlaceTypeText(for PlacePurpose: PlacePurpose?) -> String {
            guard let PlacePurpose = PlacePurpose else {
                // placeType이 nil
                return "산책"
            }
            if PlacePurpose.spot {
                return "산책"
            } else if PlacePurpose.store {
                return "가게"
            }
            // 둘 다 아닐 시
            return "산책"
        }
        
        func getPlaceTypeTextColor(for PlacePurpose: PlacePurpose?) -> Color {
            guard let PlacePurpose = PlacePurpose else {
                // placeType이 nil일 경우 처리
                return Color.green
            }
            if PlacePurpose.spot {
                return Color(red: 49 / 255, green: 97 / 255, blue: 0 / 255)
            } else if PlacePurpose.store {
                return Color(red: 222 / 255, green: 98 / 255, blue: 8 / 255)
            }
            return Color.green
        }
        
        
    }
