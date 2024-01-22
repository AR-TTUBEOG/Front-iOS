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
    @State var placeTypeColor: Color?
    @State var baseImage: Image?
    @State var placeTypeText: Text?
    
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
                .offset(x: 3 , y: 20)
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
            Icon.distance.image
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
            Icon.time.image
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
            Rectangle()
                .frame(width: calculateWidth(for: space.reviewCount), height: 14)
                .foregroundColor(Color.textBlue)
                .cornerRadius(19)
            Icon.reviewCount.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 9, height: 9)
                .offset(x: 4, y: 0)
            Text("\(space.reviewCount)")
                .font(.system(size: 7, weight: .bold))
                .foregroundColor(Color(red: 36 / 255, green: 88 / 255, blue: 139 / 255))
                .offset(x: calculateTextOffsetX(for: space.reviewCount), y: 0)
                .multilineTextAlignment(.center)
        }
        .padding(.leading, -30)
        .padding(.top, 0)
    }
    
    
    // 장소 유형
    private var spaceSpotType: some View {
        VStack {
            Rectangle()
                .frame(width: calculateWidth(for: space.reviewCount), height: 14)
                .foregroundColor(getColor(for: space.placeType.first))
                .cornerRadius(19)
            Text(getPlaceTypeText(for: space.placeType.first))
                .font(.system(size: 7, weight: .bold))
                .foregroundColor(getPlaceTypeTextColor(for: space.placeType.first))
                .offset(x: calculateTextOffsetX(for: space.reviewCount), y: -13)
            
            getImage(for: space.placeType.first)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 9, height: 9)
                .offset(x: -10, y: -27)
        }
    }
    
    func getImage(for placeType: place?) -> Image {
        guard let placeType = placeType else {
            // placeType이 nil일 경우 처리
            placeTypeColor = Color.lightGreen2
            return Image("default")
        }
        if placeType.walkingSpot {
            return Icon.tree.image
        } else if placeType.storeSpot {
            return Icon.store.image
        }
        // 둘 다 아닐 시
        placeTypeColor = Color.lightGreen2
        return Image("default")
    }
    
    func getColor(for placeType: place?) -> Color {
        guard let placeType = placeType else {
            // placeType이 nil일 경우 처리
            return Color.lightGreen2
        }
        
        if placeType.walkingSpot {
            return Color.lightGreen2
        } else if placeType.storeSpot {
            return Color.lightOrange
        }
        return Color.lightGreen2
    }
    
    func getPlaceTypeText(for placeType: place?) -> String {
            guard let placeType = placeType else {
                // placeType이 nil
                return "산책"
            }
            if placeType.walkingSpot {
                return "산책"
            } else if placeType.storeSpot {
                return "가게"
            }
            // 둘 다 아닐 시
            return "산책"
        }
    
func getPlaceTypeTextColor(for placeType: place?) -> Color {
        guard let placeType = placeType else {
            // placeType이 nil일 경우 처리
            return Color.green
        }
        if placeType.walkingSpot {
            return Color(red: 49 / 255, green: 97 / 255, blue: 0 / 255)
        } else if placeType.storeSpot {
            return Color(red: 222 / 255, green: 98 / 255, blue: 8 / 255)
        }
        return Color.green
    }
    
    func calculateTextOffsetX(for reviewCount: Int?) -> CGFloat {
        guard let reviewCount = reviewCount else {
            return (UIScreen.main.bounds.width - calculateWidth(for: reviewCount)) / 2
        }

        let textWidth = CGFloat(String(reviewCount).count) * 5 // 근사치 계산
        let minOffsetX = (calculateWidth(for: reviewCount) - textWidth) / 2
        return max(minOffsetX, 5)
    }

    func calculateWidth(for reviewCount: Int?) -> CGFloat {
         guard let reviewCount = reviewCount else {
             return 38
         }

         // 리뷰 개수에 따라 동적으로 폭 조절
         let textWidth = CGFloat(String(reviewCount).count) * 5 // 근사치
         let dynamicWidth = max(textWidth + 10, 38) // 최소값은 38, 양쪽 떨어진 범위가 각각 1이 되도록

         return max(dynamicWidth, textWidth + 20)
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
                   reviewCount: 148,
                   isFavorited: false,
                   placeType:[place(walkingSpot: true, storeSpot: false)]
               )
        RecommendedSpaceCard(space: sampleSpace)
            .previewLayout(.sizeThatFits)
    }
}
#endif




