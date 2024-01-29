//
//  DetailViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import SwiftUI

struct DetailViewControl: View {
    // MARK: - Property
    private let detailInfoInstance: DetailInfo
    @ObservedObject private var viewModel: DetailView
    private var imageNames: [String]
    private let Book = ReviewInfo()

    init(detailInfoInstance: DetailInfo, viewModel: DetailView) {
        self.detailInfoInstance = detailInfoInstance
        self.viewModel = viewModel
        self.imageNames = []
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.top) {
                Color.background.ignoresSafeArea()
                
                VStack {
                    ZStack {
                        SpaceImage
                        spaceBookmarked
                            .offset(x:160,y:-80)
                    }
                    HStack {
                        SpaceName
                        GuestVisitBook
                        GuestBook
                        
                    }
                    EventImage
                    HStack(spacing:-30){
                        Spaceinfomation
                        Count
                            .offset(y: 15)
                    }
                    HStack(spacing:-75) {
                        likesCount
                        bookCount
                    }
                    guestBookGrid(geometry: geometry)
                        .padding(.top,5)
                    
                }
            }
        }
    }
    
    //장소 사진
    private var SpaceImage : some View {
        Image(detailInfoInstance.SampleStoreInfo.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 252)
            .padding(.top, 35)
        
    }
    
    // 찜 버튼
    private var spaceBookmarked: some View {
        Button(action: {
            viewModel.toggleFavorite()
        }) {
            Image(viewModel.favoriteImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        }
    }
    
    //장소 이름
    private var SpaceName : some View {
        Text(detailInfoInstance.SampleStoreInfo.name)
            .foregroundColor(Color.white)
            .padding(.top, 25)
            .padding(.leading, 5)
            .font(.system(size: 18, weight: .bold))
    }
    
    //방문하기
    private var GuestVisitBook: some View {
        Rectangle()
            .foregroundColor(Color.white)
            .cornerRadius(19)
            .frame(width: 75, height: 27)
            .onTapGesture {
                viewModel.GuestVisitAction()
            }
            .overlay(
                Text("방문하기")
                    .foregroundColor(Color.gradient03)
                    .font(.system(size: 11, weight: .bold))
            )
            .padding(.top, 25)
            .padding(.leading, 35)
    }
    //방명록 작성
    private var GuestBook: some View {
        Rectangle()
            .foregroundColor(Color.chart)
            .cornerRadius(19)
            .frame(width: 75, height: 27)
            .onTapGesture {
                viewModel.GuestBookAction()
            }
            .overlay(
                Text("방명록 작성")
                    .foregroundColor(Color.white)
                    .font(.system(size: 11, weight: .bold))
            )
            .padding(.top, 25)
            .padding(.leading, 0)
    }
    
    //아이템들
    private var EventImage: some View {
        HStack(spacing: 10) {
            Image(getImageForBenefit(benefitName: "giftIcon"))
                .resizable()
                .frame(width: 15, height: 18)

            Image(getImageForBenefit(benefitName: "coupon"))
                .resizable()
                .frame(width: 20, height: 17)

            Image(getImageForBenefit(benefitName: "Union"))
                .resizable()
                .frame(width: 21, height: 15)
        }
        .padding(.leading, -160)
    }

    func getImageForBenefit(benefitName: String) -> String {
        let benefitsAvailable = detailInfoInstance.SampleStoreInfo.benefit

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
    
    private var Spaceinfomation : some View{
        Text(detailInfoInstance.SampleStoreInfo.info)
            .font(.system(size: 11, weight: .light))
            .foregroundColor(Color.white)
            .padding(.trailing,80)
            .padding(.top,5)
            .padding(.leading, 10)
        
    }
    
    
    // 좋아요 수
    private var likesCount : some View{
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(Color.chart)
                .cornerRadius(19)
                .frame(width: 65, height: 17)
            Icon.heartBold.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .offset(x: 7, y: 0)
            Text(viewModel.formattedReviewCount(detailInfoInstance.SampleStoreInfo.likes))
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color.white)
                .offset(x:25, y:0)
        }
        .padding(.leading,-155)
    }
    
    
    // 방명록 수
    private var bookCount : some View{
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(Color.textBlue)
                .cornerRadius(19)
                .frame(width: 55, height: 17)
            Icon.Subtract.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 9, height: 11)
                .offset(x: 7, y: 0)
            Text(viewModel.formattedReviewCount(detailInfoInstance.SampleStoreInfo.guestbook))
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color(red: 36/255, green: 88/255, blue: 139/255))
                .offset(x:20, y:0)
        }
        .padding(.leading,-5)
    }
    
    private var Count : some View {
        VStack(spacing:2) {
            HStack {
                Icon.star2.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 13)
                
                Text(String(detailInfoInstance.SampleStoreInfo.stars))
                    .font(.system(size: 11, weight:.medium))
                    .foregroundColor(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                
            }
            .offset(x:-12 , y:0)
            HStack {
                Icon.distance2.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                
                Text("\(String(detailInfoInstance.SampleStoreInfo.distance)) km")
                    .font(.system(size: 11, weight:.medium))
                    .foregroundColor(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
                
            }
            .offset(x:-3 , y:0)
            HStack {
                Icon.time2.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 11)
                
                Text("약 \(String(detailInfoInstance.SampleStoreInfo.times))분")
                    .font(.system(size: 11, weight:.medium))
                    .foregroundColor(Color(red: 133 / 255.0, green: 135 / 255.0, blue: 152 / 255.0))
            }
            .offset(x:-3 , y:0)
            
        }
        
        
    }
    
    private func guestBookGrid(geometry: GeometryProxy) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: -30), GridItem(.flexible(minimum: 150), spacing: 15)], spacing: 13) {
                   ForEach(ReviewInfo.infos, id: \.userId) { info in
                       GuestBookCard(guestBook: info)
                           .frame(minWidth: 0, maxWidth: .infinity,  minHeight: 200)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
    
}



    
struct DetailViewControl_Previews: PreviewProvider {
    static var previews: some View {
        let detailInfoInstance = DetailInfo()
        let viewModel = DetailView()
        return DetailViewControl(detailInfoInstance: detailInfoInstance, viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
