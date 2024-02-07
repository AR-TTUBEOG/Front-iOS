//
//  ExploreViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//


import SwiftUI

struct ExploreViewControl: View {
    
    // MARK: - Property
    @StateObject var viewModel: ExploreViewModel
    @StateObject var detailViewModel = DetailViewModel()
    @State private var showDetail = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            allView
        }
    }
    
    // MARK: - Explore View
    
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment:.top){
                Color.background.ignoresSafeArea()
                VStack(spacing:20){
                    mainImage
                    recommendedSpacesGrid(geometry: geometry)
                }
                .padding(.top,108.6)
            }
        }
    }
    
    //뚜벅 메인페이지 슬로건
    private var mainImage: some View {
        Image("banner")
            .resizable()
            .frame(minWidth: 0, maxWidth: .infinity)
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 20)
        
    }
    
    // 추천 장소
    private func recommendedSpacesGrid(geometry: GeometryProxy) -> some View {
        ScrollView(.vertical) {
            refreshable {
                viewModel.fetchExploreData(page: 1)
            }
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: -8), GridItem(.flexible(minimum: 150), spacing: 15)], spacing: 25) {
                ForEach(self.viewModel.exploreData?.information ?? [], id: \.self) { place in
                    RecommendedSpaceCard(viewModel: viewModel, exploreDetailInfor: place)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .onAppear {
                            viewModel.exploreDetailInfor = place
                            if place == self.viewModel.exploreData?.information.last {
                                viewModel.fetchExploreData(page: viewModel.curretnPage + 1)
                            }
                        }
                        .onTapGesture {
                            self.detailViewModel.fetchDetails(for: place)
                            showDetail = true
                        }
                        .navigationDestination(isPresented: $showDetail) {
                            DetailViewControl(viewModel: detailViewModel)
                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}



// MARK: - Preview

