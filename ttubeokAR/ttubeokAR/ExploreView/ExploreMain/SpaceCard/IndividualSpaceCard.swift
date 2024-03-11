//
//  RecommendedSpaceCard.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import SwiftUI

struct IndividualSpaceCard: View {
    // MARK: - Property
    @State private var isFavorited = false
    @State var placeTypeColor: Color?
    @State var baseImage: Image?
    @State var placeTypeText: Text?
    @StateObject var viewModel: IndividualSpaceCardViewModel
    
    
    // 장소 타입 저장할 변수 필요
    
    // MARK: - Body
    var body: some View {
        
        allView
            .frame(maxWidth: 180, maxHeight: 240)
            .background(Color(red: 0.25, green: 0.24, blue: 0.37))
            .clipShape(.rect(cornerRadius: 19))
            .shadow(radius: 5)
            .onReceive(BaseLocationManager.shared.$currentLocation) { _ in
                viewModel.updateDistanceAndTIme()
            }
            .onAppear {
                if let place = viewModel.exploreDetailInfor?.placeType {
                    place.spot ? viewModel.walkImageGet() : viewModel.storeImageGet()
                }
            }
    }
    
    //MARK: - ViewSetting
    /// 등록된 장소에 대한 뷰에 담기는 컴포넌트 담당
    private var allView: some View {
        VStack(spacing: 4) {
            topView
            HStack(spacing: 16){
                bottomLeftSpaceInfo
                bottomRightSpaceInfo
            }
            .padding(.bottom, 5)
        }
    }
    
    private var topView: some View {
        VStack(spacing: 10) {
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
        .frame(maxWidth: 80, alignment: .leading)
    }
    
    private var bottomRightSpaceInfo: some View {
        VStack(spacing: 6) {
            spaceReviewCount
            spaceSpotType
            Spacer()
                .frame(maxHeight: 2)
        }
        .padding(.top, 7)
    }
    
    
    // MARK: - 장소 이미지 및 이름
    
    //장소 이미지
    private var spaceImage : some View {
        AsyncImage(url: URL(string: viewModel.exploreDetailInfor?.image ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .frame(maxWidth: 170, maxHeight: 120)
                    .aspectRatio(contentMode: .fill)
                    .roundedCorner(19, corners: [.topLeft, .topRight])
                    .padding(.top, 5)
            case .failure(_):
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    
    /// 장소 이름
    private var spaceName : some View {
        Text(viewModel.exploreDetailInfor?.name ?? "")
            .font(.sandol(type: .bold, size: 18))
            .foregroundColor(Color.textPink)
            .frame(maxWidth: 130, maxHeight: 19, alignment: .center)
    }
    
    /// 장소 좋아요 버튼
    private var spaceLiked: some View {
        Button(action: {
            
            if !isFavorited {
                viewModel.sendLike()
            }
            self.isFavorited = true
        }) {
            Image(self.isFavorited ? "checkHeart" : "unCheckHeart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 20, maxHeight: 20)
        }
    }
    
    // MARK: - 장소 간단 정보
    
    
    /// 장소 별점 관리
    private var spaceRating: some View {
        HStack(spacing: 4) {
            Icon.checkStart.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 15, maxHeight: 13)
            
            Text(String(viewModel.exploreDetailInfor?.stars ?? 0.0))
                .frame(maxWidth: 25, maxHeight: 16, alignment: .leading)
                .font(.sandol(type: .regular, size: 12))
                .foregroundColor(Color.textPink)
            
        }
        .frame(maxWidth: 55, maxHeight: 14, alignment: .leading)
    }
    
    
    /// 현재 위치부터 걸리는 거리
    private var spaceDistance: some View {
        HStack(spacing: 5) {
            Icon.distance.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 12, maxHeight: 12)
            Text(formatDistance(viewModel.distance))
                .font(.sandol(type: .regular, size: 11))
                .foregroundColor(.textPink)
                .frame(maxWidth: 40, maxHeight: 15, alignment: .leading)
        }
        .frame(maxWidth: 60, maxHeight: 15, alignment: .leading)
        .padding(.leading, 2)
    }
    
    
    /// 거리 데이터 수치 값을 문자값으로 리턴
    /// - Parameter distance: 거리값
    /// - Returns: km 단위로 표시하여 나타낸ㄴ다
    func formatDistance(_ distance: Double) -> String {
        if (distance / 1000) > 100 {
            return "99km+"
        } else {
            return String(format: "%.1f km", distance / 1000)
        }
    }
    
    /// 걸리는 시간 표시
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
        .frame(maxWidth: 60, maxHeight: 15, alignment: .leading)
        .padding(.leading, 3)
    }
    
    /// 시간 데이터 문자열로 전환
    /// - Parameter time: 계산된 거리 시간 값
    /// - Returns: 분 단위로 표시한다.
    func formatEstimatedTime(_ time: Double) -> String {
        let minutes = Int(round(time / 60))
        if minutes > 1000 {
            return "999+ 분"
        } else {
            return "약 \(minutes)분"
        }
    }
    
    // MARK: - 방명록 수 및 타입 이미지
    
    /// 리뷰 개수
    private var spaceReviewCount: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: 50, height: 20)
                .foregroundColor(Color.textBlue)
                .clipShape(.rect(cornerRadius: 19))
            HStack(alignment: .center, spacing: 6) {
                Icon.reviewCount.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 9, maxHeight: 9)
                Text(formattedReviewCount(viewModel.exploreDetailInfor?.guestbookCount ?? 0))
                    .font(.sandol(type: .bold, size: 9))
                    .foregroundStyle(Color(red: 36 / 255, green: 88 / 255, blue: 139 / 255))
            }
            .frame(maxWidth: 20, alignment: .center)
        }
    }
    
    
    /// 장소 유형
    private var spaceSpotType: some View {
        ZStack(alignment: .center) {
            
            Rectangle()
                .frame(width: 53, height: 20)
                .foregroundStyle(getColor(for: viewModel.exploreDetailInfor?.placeType))
                .clipShape(.rect(cornerRadius: 19))
            
            HStack(alignment: .center, spacing: 6) {
                getImage(for: viewModel.exploreDetailInfor?.placeType)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 9, maxHeight: 9)
                Text(getPlaceTypeText(for: viewModel.exploreDetailInfor?.placeType))
                    .font(.sandol(type: .bold, size: 9))
                    .foregroundStyle(getPlaceTypeTextColor(for: viewModel.exploreDetailInfor?.placeType))
            }
        }
    }
    
    
    /// 장소 타입에 맞추어 이미지 얻어온다.
    /// - Parameter PlacePurpose: 장소 타입 파라미터
    /// - Returns: 장소 타입에 맞춘 이미지 전환
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
    
    
    /// 장소 타입에 맞추어 컬러 얻어온다.
    /// - Parameter PlacePurpose: 장소 타입 파라미터
    /// - Returns: 장소 타입에 맞춘 컬러 반환
    func getColor(for PlacePurpose: PlaceType?) -> Color {
        guard let PlacePurpose = PlacePurpose else {
            return Color.lightGreen2
        }
        
        if (PlacePurpose.spot) {
            return Color.lightGreen2
        } else if (PlacePurpose.store) {
            return Color.lightOrange
        }
        return Color.lightGreen2
    }
    
    /// 장소 타입에 맞춘 텍스트 얻어온다.
    /// - Parameter PlacePurpose: 장소 타입 파라미터
    /// - Returns: 장소 타입에 맞춘 텍스트 반환
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
    
    /// 장소 타입에 맞춘 컬러 색상
    /// - Parameter PlacePurpose: 장소 타입 파라미터
    /// - Returns: 장소 타입에 맞춘 텍스트 컬러 반환
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
