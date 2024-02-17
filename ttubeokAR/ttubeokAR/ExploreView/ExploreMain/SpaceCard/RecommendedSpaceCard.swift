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
    @StateObject var viewModel: RecommendedSpaceCardViewModel
    
    
    // 장소 타입 저장할 변수 필요
    
    // MARK: - Body
    
    var body: some View {
        allView
            .frame(width: 175, height: 190)
            .background(Color(red: 0.25, green: 0.24, blue: 0.37))
            .clipShape(.rect(cornerRadius: 19))
            .shadow(radius: 5)
//            .onReceive(BaseLocationManager.shared.$currentLocation) { _ in
//                viewModel.updateDistanceAndTIme()
//            }
    }
    
    //MARK: - ViewSetting
    private var allView: some View {
        VStack(spacing:0) {
            topView
            HStack(spacing: 13){
                bottomLeftSpaceInfo
                bottomRightSpaceInfo
            }
        }
    }
    
    private var topView: some View {
        VStack(spacing: 5) {
            topInfor
            spaceName
        }
    }
    
    private var topInfor: some View {
        ZStack(alignment: .topTrailing){
            spaceImage
            spaceLiked
                .padding(.top, 9)
                .padding(.trailing, 10)
        }
    }
    
    private var bottomLeftSpaceInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            spaceRating
            spaceDistance
            spaceTime
        }
        .frame(width: 70, alignment: .leading)
    }
    
    private var bottomRightSpaceInfo: some View {
        VStack(spacing: 4) {
            spaceReviewCount
            spaceSpotType
            Spacer()
                .frame(height: 2)
        }
        .padding(.top, 7)
    }
    
    
    //    // MARK: - 장소 이미지 및 이름
    //장소 이미지
    private var spaceImage : some View {
        Image(base64String: viewModel.exploreDetailInfor?.image ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 94)
            .roundedCorner(19, corners: [.topLeft, .topRight])
            .padding(.top, 5)
    }
    
    //장소 이름
    private var spaceName : some View {
        Text(viewModel.exploreDetailInfor?.name ?? "")
            .font(.sandol(type: .bold, size: 18))
            .foregroundColor(Color.textPink)
            .frame(width: 130, height: 19, alignment: .center)
    }
    
    //    //장소 좋아요
    private var spaceLiked: some View {
        Button(action: {
            self.isFavorited.toggle()
            print("좋아요 상태 : \(isFavorited)")
            
            if isFavorited {
                viewModel.sendLike()
            }
            
        }) {
            Image(self.isFavorited ? "checkHeart" : "unCheckHeart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
        }
    }
    //
    //        // MARK: - 장소 간단 정보
    // 별점
    private var spaceRating: some View {
        HStack(spacing: 4) {
            Icon.checkStart.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 13)
            
            Text(String(viewModel.exploreDetailInfor?.stars ?? 0.0))
                .frame(width: 25, height: 16, alignment: .leading)
                .font(.sandol(type: .regular, size: 12))
                .foregroundColor(Color.textPink)
            
        }
        .frame(width: 50, height: 16, alignment: .leading)
    }
    
    //거리
    private var spaceDistance: some View {
        HStack(spacing: 5) {
            Icon.distance.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12, height: 12)
            Text(formatDistance(viewModel.distance))
                .font(.sandol(type: .regular, size: 11))
                .foregroundColor(.textPink)
                .frame(width: 40, height: 15, alignment: .leading)
        }
        .frame(width: 60, height: 15, alignment: .leading)
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
        HStack(spacing: 5) {
            Icon.checkTime.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 11, maxHeight: 11)
            
            Text( formatEstimatedTime(viewModel.estimatedTime))
                .font(.sandol(type: .regular, size: 11))
                .foregroundColor(Color.textPink)
                .frame(maxWidth: 40, maxHeight: 15, alignment: .leading)
        }
        .frame(width: 60, height: 15, alignment: .leading)
    }
    
    func formatEstimatedTime(_ time: Double) -> String {
        let minutes = Int(round(time / 60))
        if minutes > 1000 {
            return "999+ 분"
        } else {
            return "약 \(minutes)분"
        }
    }
    
    //        //MARK: - 방명록 수 및 타입 이미지
    //
    //리뷰 개수
    private var spaceReviewCount: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: 40, height: 18)
                .foregroundColor(Color.textBlue)
                .clipShape(.rect(cornerRadius: 19))
            HStack(spacing: 2) {
                Icon.reviewCount.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 9, height: 9)
                Text(formattedReviewCount(viewModel.exploreDetailInfor?.guestbookCount ?? 0))
                    .font(.sandol(type: .bold, size: 9))
                    .foregroundStyle(Color(red: 36 / 255, green: 88 / 255, blue: 139 / 255))
            }
            .frame(width: 20)
        }
    }
    
    
    // 장소 유형
    private var spaceSpotType: some View {
        ZStack(alignment: .center) {
            
            Rectangle()
                .frame(maxWidth: 40, maxHeight: 18)
                .foregroundStyle(getColor(for: viewModel.exploreDetailInfor?.placeType))
                .clipShape(.rect(cornerRadius: 19))
            
            HStack(spacing: 2) {
                getImage(for: viewModel.exploreDetailInfor?.placeType)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 9, height: 9)
                Text(getPlaceTypeText(for: viewModel.exploreDetailInfor?.placeType))
                    .font(.sandol(type: .bold, size: 9))
                    .foregroundStyle(getPlaceTypeTextColor(for: viewModel.exploreDetailInfor?.placeType))
            }
        }
    }
    //
    func getImage(for PlacePurpose: PlaceType?) -> SwiftUI.Image {
        guard let PlacePurpose = PlacePurpose else {
            placeTypeColor = Color.lightGreen2
            return Image("default")
        }
        if (PlacePurpose.store) {
            return Icon.tree.image
        } else if (PlacePurpose.spot) {
            return Icon.store.image
        }
        
        placeTypeColor = Color.lightGreen2
        return Image("default")
    }
    
    func getColor(for PlacePurpose: PlaceType?) -> Color {
        guard let PlacePurpose = PlacePurpose else {
            // placeType이 nil일 경우 처리
            return Color.lightGreen2
        }
        
        if (PlacePurpose.spot) {
            return Color.lightGreen2
        } else if (PlacePurpose.store) {
            return Color.lightOrange
        }
        return Color.lightGreen2
    }
    
    func getPlaceTypeText(for PlacePurpose: PlaceType?) -> String {
        guard let PlacePurpose = PlacePurpose else {
            return "산책"
        }
        if (PlacePurpose.spot) {
            return "산책"
        } else if (PlacePurpose.store) {
            return "가게"
        }
        // 둘 다 아닐 시
        return "산책"
    }
    
    func getPlaceTypeTextColor(for PlacePurpose: PlaceType?) -> Color {
        guard let PlacePurpose = PlacePurpose else {
            // placeType이 nil일 경우 처리
            return Color.green
        }
        if (PlacePurpose.spot) {
            return Color(red: 49 / 255, green: 97 / 255, blue: 0 / 255)
        } else if (PlacePurpose.store) {
            return Color(red: 222 / 255, green: 98 / 255, blue: 8 / 255)
        }
        return Color.green
    }
    
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
}
