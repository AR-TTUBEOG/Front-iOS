//
//  DetailViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import SwiftUI

struct DetailViewControl: View {
    // MARK: - Property
    @StateObject var viewModel = DetailViewModel()
    @Binding var SelectedCard: ExploreViewModel?
    let GuestBookModel : GuestBookModel

    
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
                    
                    guestBookGrid
                }
            }
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
        }
        //Explore뷰에서 클릭했을때 작동이 되도록 해애함 (카드를 선택했을때) 바인딩을 사용하여(같은 메모리 주소를 공유) 두개의 뷰모델을 공유하도록 해야함
        .onAppear {
            // 선택된 카드의 정보를 확인하고 상세 정보를 불러옵니다.
            viewModel.fetchExploreDetail(storeId: StoreInformation.storeId) { result in
                    switch result {
                    case .success(let detailDataModel):
                        // 성공 시 처리 로직
                        print("성공: \(detailDataModel)")
                    case .failure(let error):
                        // 실패 시 처리 로직
                        print("오류: \(error.localizedDescription)")
                    }
                }
            }
        }
    
    //MARK: - 장소 사진 및 찜하기
    
    /// 장소  사진  및 찜하기 버튼
    private var topImageAndBookmarked: some View {
        ZStack(alignment: .topTrailing) {
            SpaceImage
            spaceBookmarked
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 226)
    }
    
    //장소 사진
    private var SpaceImage : some View {
        Image(StoreInformation.image)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: 252)
    }
    
    // 찜 버튼
    private var spaceBookmarked: some View {
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
    
    //TODO: - API 만들고 바꿀것
    //장소 이름
    private var spaceName : some View {
        Text(StoreInformation.name)
            .foregroundStyle(Color.textPink)
            .font(.sandol(type: .bold, size: 18))
            .multilineTextAlignment(.leading)
            .kerning(0.9)
            .frame(maxWidth: 280, maxHeight: 24,alignment: .leading)
    }
    
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
    
    //방명록 작성
    private var guestBook: some View {
        Button(action: {
                let guestBookService = viewModel
                guestBookService.createGuestBookEntry(name: GuestBookModel.userName, message: GuestBookModel.content) { result in
                    switch result {
                    case .success(let response):
                        print("방명록 작성 성공: \(response)")
                    case .failure(let error):
                        print("방명록 작성 실패: \(error.localizedDescription)")
                    }
                }
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
            Image(getImageForBenefit(benefitName: "giftIcon"))
                .resizable()
                .frame(maxWidth: 15, maxHeight: 15)
            
            Image(getImageForBenefit(benefitName: "coupon"))
                .resizable()
                .frame(maxWidth: 20, maxHeight: 15)
            
            Image(getImageForBenefit(benefitName: "Union"))
                .resizable()
                .frame(maxWidth: 21, maxHeight: 15)
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: 100, maxHeight: 25, alignment: .center)
    }
    
    /// 아이템 이름 받아오기
    /// - Parameter benefitName: 받아올 아이템 이름
    /// - Returns: 이미지
    func getImageForBenefit(benefitName: String) -> String {
        let benefitsAvailable = StoreInformation.benefit
        
        switch benefitName {
        case "giftIcon":
            return benefitsAvailable.contains("giftIcon") ? "giftIcon" : "giftIcon2"
        case "coupon":
            return benefitsAvailable.contains("coupon") ? "coupon" : "coupon2"
        case "Union":
            return benefitsAvailable.contains("Union") ? "Union" : "Union2"
        default:
            return "defaultImage"
        }
    }
    
    //MARK: - 장소 정보(설명, 시간, 길이)
    
    private var groupspaceInfor: some View {
        HStack(alignment: .center, spacing: 40) {
            spaceInfomation
            count
        }
        .frame(maxWidth: 370, maxHeight: 80)
    }
    
    /// 장소 설명 글
    private var spaceInfomation : some View{
        Text(StoreInformation.info)
            .font(.sandol(type: .regular, size: 11))
            .foregroundStyle(Color(red: 0.85, green: 0.85, blue: 0.85))
            .multilineTextAlignment(.leading)
            .lineSpacing(1)
            .frame(maxWidth: 320, maxHeight: 47, alignment: .leading)
    }
    
    private var count : some View {
            VStack(alignment: .center, spacing: 2) {
                HStack(alignment: .center, spacing: 3) {
                    Icon.star2.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 13, maxHeight: 13)
                    
                    Text(String(StoreInformation.stars))
                        .frame(maxWidth: 42, maxHeight: 16, alignment: .leading)
                        .font(.sandol(type: .bold, size: 11))
                        .foregroundStyle(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                }
                
                HStack(alignment: .center, spacing: 3) {
                    Icon.distance2.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                    Text(formatDistance(viewModel.distance))
                        .font(.sandol(type: .bold, size: 11))
                        .foregroundStyle(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                        .frame(maxWidth: 42, maxHeight: 16, alignment: .leading)
                    
                }
                
                HStack(alignment: .center, spacing: 3) {
                    Icon.time2.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 11)
                    
                    Text(formatEstimatedTime(viewModel.estimatedTime))
                        .font(.sandol(type: .bold, size: 11))
                        .foregroundStyle(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                        .frame(maxWidth: 42, maxHeight: 16, alignment: .leading)
                }
                
            }
            .onAppear{
                viewModel.locationManager.startUpdatingLocation()
            }
        }
    
    func formatDistance(_ distance: Double) -> String {
        if distance > 100 {
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
                Text(viewModel.formattedReviewCount(StoreInformation.likes))
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
                Text(viewModel.formattedReviewCount(StoreInformation.guestbook))
                    .font(.sandol(type: .bold, size: 11))
                    .foregroundStyle(Color(red: 36/255, green: 88/255, blue: 139/255))
            }
        }
        
    }
    
    
    //MARK: - 스크롤 방명록 보기
    private var guestBookGrid: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: 10), GridItem(.flexible(minimum: 150), spacing: 100)], spacing: 13) {
                // 안전하게 옵셔널을 처리하기 위해 옵셔널 바인딩 사용
                if let informationList = self.viewModel.exploreDetailData?.information {
                    ForEach(informationList, id: \.storeId) { information in
                        GuestBookCard(viewModel: viewModel,GuestBookModel: GuestBookModel, StoreInformation: information)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                    }
                }
            }
        }
        .frame(maxWidth: 300, maxHeight: .infinity, alignment: .center)
    }
    
}





