//
//  ExploreViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//


import SwiftUI

struct ExploreViewControl: View {
    
    // MARK: - Property
    @StateObject private var viewModel = SearchViewModel()
    
    //테스트 데이터들
    @State var spaces: [RecommendedSpaceModel] = [
        RecommendedSpaceModel(placeName: "낙산공원 한양도성길", placePhoto: "spaceTest", starRating: 4.5, distance: 2.3, time: "15", reviewCount: 15 ,isFavorited: false),
        RecommendedSpaceModel(placeName: "Place 2", placePhoto: "photo2", starRating: 3.8, distance: 1.5, time: "15", reviewCount: 10,isFavorited: false),
        RecommendedSpaceModel(placeName: "Place 3", placePhoto: "photo2", starRating: 3.8, distance: 1.5, time: "15", reviewCount: 10,isFavorited: false),
        RecommendedSpaceModel(placeName: "Place 4", placePhoto: "photo2", starRating: 3.8, distance: 1.5, time: "15", reviewCount: 10,isFavorited: false),
        RecommendedSpaceModel(placeName: "Place 5", placePhoto: "photo2", starRating: 3.8, distance: 1.5, time: "15", reviewCount: 10,isFavorited: false),
    ]
    
    //그리드는 모델 파일을 따로 만들었으니, 그 모델에 대한 값을 넘겨받아서 레이지 그리드에 나오도록 구현
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.top){
                Color.background.ignoresSafeArea()
                VStack(spacing:30){
                    mainImage
                    recommendedSpacesGrid(geometry: geometry)
                }
                .padding(.top,108.6)
            }
        }
    }
    
    // MARK: - Explore View
    
    //뚜벅 메인페이지 슬로건
    private var mainImage: some View {
        Image("banner")
            .resizable()
            .frame(minWidth: 0, maxWidth: .infinity)
            .aspectRatio(contentMode: .fit)
        
    }
    
    // 추천 장소
    private func recommendedSpacesGrid(geometry: GeometryProxy) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150)), GridItem(.flexible(minimum: 150))], spacing: 25) {
                ForEach(spaces, id: \.placeName) { space in
                    RecommendedSpaceCard(space: space)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .padding()
            //.frame(maxWidth: .infinity)
        }
        .frame(height: geometry.size.height)
    }
}


// MARK: - Preview

#Preview {
    ExploreViewControl()
}


