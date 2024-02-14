//
//  ExploreViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//


import SwiftUI

struct ExploreViewControl: View {
    
    // MARK: - Property
    @StateObject var viewModel:  ExploreViewModel
    @StateObject var detailViewModel = DetailViewModel()
    @State private var showDetail = false
    @State private var keyboardVisible = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            allView
                .onAppear {
                    observeKeyboard()
                }
        }
    }
    
    // MARK: - Explore View
    
    private var allView: some View {
        ZStack(alignment:.top){
            GeometryReader { geometry in
                Color.background.ignoresSafeArea()
                VStack(spacing:20){
                    if !keyboardVisible {
                        mainImage
                    }
                    centerView(geometry: geometry)
                        .onAppear {
                            print("--------------MainViewControll 초기 호출--------------")
                            viewModel.fetchDataSearch(viewModel.currentSearchType, page: 1)
                        }
                }
                .padding(.top,108.6)
            }
        }
    }
    
    private func imgBackground(geometry: GeometryProxy) -> some View {
        Icon.backgroundLogo.image
            .fixedSize()
            .aspectRatio(contentMode: .fit)
            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.32)
    }
    
    //뚜벅 메인페이지 슬로건
    private var mainImage: some View {
        Image("banner")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: 90)
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 20)
        
    }
    
    
    private func centerView(geometry: GeometryProxy) -> some View {
        if let information = viewModel.exploreData?.information, !information.isEmpty {
            return AnyView(recommendedSpacesGrid(geometry: geometry))
        } else {
            return AnyView(imgBackground(geometry: geometry))
        }
    }
    
    // 추천 장소
    private func recommendedSpacesGrid(geometry: GeometryProxy) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: -8), GridItem(.flexible(minimum: 150), spacing: 15)], spacing: 25) {
                ForEach(self.viewModel.exploreData?.information ?? [], id: \.self) { place in
                    RecommendedSpaceCard(exploreDataInfor: place)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .onAppear {
                            print("--------------LazyGrid 마지막 페이지 호출--------------")
                            if place == self.viewModel.exploreData?.information.last {
                                viewModel.fetchDataSearch(viewModel.currentSearchType, page: viewModel.curretnPage + 1)
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
        .refreshable {
            print("--------------refresh 호출--------------")
            viewModel.fetchDataSearch(viewModel.currentSearchType, page: 1)
        }
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil, queue: .main
        ) { _ in
            keyboardVisible = true
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil, queue: .main
        ) { _ in
            keyboardVisible = false
        }
    }
}
