//
//  RecommendedSpaceCard.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import SwiftUI

struct RecommendedSpaceCard: View {
    // MARK: - Property
    @State var space: RecommendedSpaceModel
    @State private var isFavorited = false
    @StateObject var viewModel = ExploreViewModel()

    // MARK: - Body
    
    var body: some View {
        VStack(spacing:0) {
            ZStack{
                spaceImage
                spaceBookmarked
                    .offset(x: 52, y: -20)
            }
            spaceName
            HStack{
                VStack(spacing:1){
                    spaceRating
                    spaceDistance
                    spaceTime
                }
                .offset(x: 20 , y: 0)
                VStack(spacing:1.3) {
                    spaceReviewCount
                        .offset(x: 56, y: -17)
                
                    spaceSpotType
                        .offset(x: 41, y: -15)
                }
                .offset(x: 3 , y: 10)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            Spacer()
        }
        .padding(.top, 0)
        .background(Color.btnBackground)
        .cornerRadius(19)
        .frame(width: 150, height: 180)
        .shadow(radius: 5)
    }
    
    // MARK: - SpaceCard View
    
    //장소 이미지
    private var spaceImage : some View {
        VStack(spacing:0) {
            Image(space.placePhoto)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 80)
                .cornerRadius(10)
                .clipped()
        }
        .padding(.top, 3)
        .padding(.horizontal, 3)
    }
    
    //장소 이름
    private var spaceName : some View {
        Text(space.placeName)
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.white)
            .padding(8)
    }
    
    //장소 북마크
    private var spaceBookmarked: some View {
           Button(action: {
               // 찜 버튼을 눌렀을 때 동작
               viewModel.toggleFavorite()
           }) {
               Image(viewModel.favoriteImageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 20, height: 20)
           }
    }
    
    
    // 별점
    private var spaceRating: some View {
        HStack {
            Image("starRating")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 13)
            
            Text(String(space.starRating))
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.white)
        }
        .padding(.leading, -62)
        .padding(.top, 0)
    }
    
    // 거리
    private var spaceDistance: some View {
        HStack {
            Image("distance")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12, height: 12)
            
            Text("\(String(format: "%.1f", space.distance)) km")
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.white)
        }
        .padding(.leading, -62)
        .padding(.top, 0)
    }
    
    //시간
    private var spaceTime: some View {
        HStack {
            Image("time")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 11, height: 11)
            
            
            Text("약 \(space.time)분")
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.white)
        }
        .padding(.leading, -62)
        .padding(.top, 0)
    }
    
    //리뷰 개수
    private var spaceReviewCount: some View {
        ZStack(alignment: .leading) {
            Image("reviewCount")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 14)
            


            Text("\(space.reviewCount)")
                .font(.system(size: 7, weight: .bold))
                .foregroundColor(Color(red: 36 / 255, green: 88 / 255, blue: 139 / 255))  
                .offset(x: 15)

        }
        .padding(.leading, -30)
        .padding(.top, 0)
    }
    
    private var spaceSpotType: some View {
        VStack {
            getImage(for: space.placeType.first) 
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 37.5, height: 13)
        }
    }

    func getImage(for placeType: place?) -> Image {
        guard let placeType = placeType else {
            // placeType이 nil일 경우 처리
            return Image("default")
        }

        if placeType.walkingSpot {
            return Image("Walk")
        } else if placeType.storeSpot {
            return Image("Store")
        } else {
            // 둘 다 아닐 시
            return Image("default")
        }
    }
    
}
    
    


// MARK: - Preview
#if DEBUG
struct RecommendedSpaceCard_reviews: PreviewProvider {
    static var previews: some View {
               let sampleSpace = RecommendedSpaceModel(
                   placeName: "낙산공원 한양도성길",
                   placePhoto: "spaceTest",
                   starRating: 4.5,
                   distance: 2.3,
                   time: "15",
                   reviewCount: 134,
                   isFavorited: false,
                   placeType:[place(walkingSpot: true, storeSpot: false)]
               )
        RecommendedSpaceCard(space: sampleSpace)
            .previewLayout(.sizeThatFits)
    }
}
#endif




