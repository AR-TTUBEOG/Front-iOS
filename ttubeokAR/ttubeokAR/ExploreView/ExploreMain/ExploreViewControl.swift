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
    @State private var keyboardVisible = false
    
    // MARK: - Body
    var body: some View {
        allView
            .onAppear {
                observeKeyboard()
                viewModel.fetchDataSearch(viewModel.currentSearchType, page: 0)
            }
    }
    
    // MARK: - Explore View
    
    /// 모든 뷰
    private var allView: some View {
        ZStack(alignment: .top){
            GeometryReader { geometry in
                Color.background.ignoresSafeArea()
                VStack(spacing:20){
                    if !keyboardVisible {
                        mainImage
                    }
                    centerView(geometry: geometry)
                }
                .padding(.top,108.6)
            }
        }
    }
    
    /// 불러온 장소 없을 시 배경 이미지 보이기
    /// - Parameter geometry: 사용하고 있는 디바이스에 맞추어 이미지 크기 조절
    /// - Returns: 이미지 리턴
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
    
    
    /// 데이터 불러오기 성공했을 경우, 장소를 보이지만 아닌 경우 빈 장소 이미지를 불러온다.
    /// - Parameter geometry: 사용하고 있는 디바이스에 맞추어 이미지 크기 조절
    /// - Returns: 이미지 리턴
    private func centerView(geometry: GeometryProxy) -> some View {
        if let information = viewModel.exploreData?.information, !information.isEmpty {
            return AnyView(wholeSpacesGrid)
        } else {
            return AnyView(imgBackground(geometry: geometry))
        }
    }
    
    /// 전체 스페이스 카드를 가져온다.
    private var wholeSpacesGrid: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: -8), GridItem(.flexible(minimum: 150), spacing: 15)], spacing: 20) {
                ForEach(self.viewModel.exploreData?.information ?? [], id: \.self) { place in
                    IndividualSpaceCard(viewModel: IndividualSpaceCardViewModel(exploreDetailInfor: place))
                    
                        .onAppear {
                            if place == self.viewModel.exploreData?.information.last {
                                print("--------------LazyGrid 마지막 페이지 호출--------------")
                                viewModel.fetchDataSearch(viewModel.currentSearchType, page: viewModel.curretnPage + 1)
                            }
                        }
                        .onTapGesture {
                            self.detailViewModel.fetchDetails(for: place)
                            showDetail = true
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .refreshable {
            print("--------------refresh 새로고침 진행--------------")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.fetchDataSearch(viewModel.currentSearchType, page: 0)
            }
        }
        
        .navigationDestination(isPresented: $showDetail) {
            DetailViewControl(viewModel: detailViewModel)
        }
        
        
    }
    
    private func observeKeyboard(){
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

struct ExploreViewControl_Preview: PreviewProvider {
    static var previews: some View {
        ExploreViewControl(viewModel: ExploreViewModel())
    }
}
