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
    let viewModel : ExploreViewModel
    let exploreDetailInfor: ExploreDetailInfor

    // 장소 타입 저장할 변수 필요
    
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
            Image(exploreDetailInfor.image)
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
        Text(exploreDetailInfor.name)
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
            
            Text(String(exploreDetailInfor.stars))
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.white)
        }
        .padding(.leading, -62)
        .padding(.top, 0)
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
    
    //거리
    private var spaceDistance: some View {
           HStack {
               Icon.distance.image
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 12, height: 12)
               //거리 수정
               Text("\(String(format: "%.1f", formatEstimatedTime(viewModel.distance))) km")
                   .font(.system(size: 13, weight: .light))
                   .foregroundColor(.white)
           }
           .padding(.leading, -62)
           .padding(.top, 0)
       }

       // 시간
       private var spaceTime: some View {
           HStack {
               Icon.time.image
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 11, height: 11)
               
               Text("약 \(formatEstimatedTime(viewModel.estimatedTime))분")
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
                .frame(width: 36, height: 13)
                .foregroundColor(Color.textBlue)
                .cornerRadius(19)
            Icon.reviewCount.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 9, height: 9)
                .offset(x: 4, y: 0)
            Text(viewModel.formattedReviewCount(exploreDetailInfor.guestbookCount))
                .font(.system(size: 7, weight: .bold))
                .foregroundColor(Color(red: 36 / 255, green: 88 / 255, blue: 139 / 255))
                .offset(x:13, y:0)
        }
        .padding(.leading, -30)
        .padding(.top, 0)
    }
    
    
    // 장소 유형
    private var spaceSpotType: some View {
        VStack {
            Rectangle()
                .frame(width: 36, height: 13)
                .foregroundColor(getColor(for: exploreDetailInfor.place.first))
                .cornerRadius(19)
            Text(getPlaceTypeText(for: exploreDetailInfor.place.first))
                .font(.system(size: 7, weight: .bold))
                .foregroundColor(getPlaceTypeTextColor(for: exploreDetailInfor.place.first))
                .offset(x: 4, y: -13)
            getImage(for: exploreDetailInfor.place.first)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 9, height: 9)
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




