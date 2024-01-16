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
                .offset(x: 10 , y: 0)
                spaceReviewCount
                    .offset(x: 56, y: -17)
            }
            
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
    }
    
    //장소 이름
    private var spaceName : some View {
        Text(space.placeName)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .padding(8)
    }
    
    //장소 북마크
    private var spaceBookmarked: some View {
           Button(action: {
               // 찜 버튼을 눌렀을 때 동작
               isFavorited.toggle()
           }) {
               Image(uiImage: UIImage(named: isFavorited ? "Vector" : "Vector2")!)
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
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.chart)
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
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.chart)
        }
        .padding(.leading, -60)
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
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.chart)
        }
        .padding(.leading, -60)
        .padding(.top, 0)
    }
    
    //리뷰 개수
    private var spaceReviewCount: some View {
        HStack(spacing:3) {
            Image("reviewCount")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7, height: 9)
            

            Text("\(space.reviewCount) 개")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.textPink)
        }
        .padding(.leading, -30)
        .padding(.top, 0)
    }
    
    
    
}

// MARK: - Preview
#if DEBUG
struct RecommendedSpaceCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleSpace = RecommendedSpaceModel(
            placeName: "낙산공원 한양도성길",
            placePhoto: "spaceTest",
            starRating: 4.5,
            distance: 2.3,
            time: "15",
            reviewCount: 15,
            isFavorited: false
        )
        RecommendedSpaceCard(space: sampleSpace)
            .previewLayout(.sizeThatFits)
    }
}
#endif



