//
//  TabBarButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/10/24.
//

import SwiftUI

/// 온보드 화면이 끝난 후 rootView가 될 메인탭 컨트롤
struct MainViewControl: View {
    
    /**
     viewModel : 뷰 모델 사용하기 위한 변수
     selectedTab : 현재 선택된 탭 버튼을 알기 위함 -> 나중에 현재 뷰를 추적하기 위해 필요
     changeTabView : 현재 뷰가 전환이 가능한가 불가능한가 정하기 위함 -> 뚜닷 버튼 때문에 필요
     ttuDOtButtonAngle : 뚜닷 버튼이 나타날 때 회전 애니메이션으로 나타나도록 하기 위함
     */
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var selectedTab = 1
    @State private var showTtuDotButton = false
    @State private var changeTabView = true
    @State private var ttuDotButtonAngle: Double = -90
    
    //MARK: Body
    var body: some View {
        ZStack {
            mainTabVieew
            searchControl
            tabBarButton
        }
    }
    
    //MARK: - Tab View
    
    /// 메인뷰의 변화를 위함 :: ExploreView, MainView의 전환
    private var mainTabVieew: some View {
        ZStack(alignment: .center) {
            TabView(selection: $selectedTab) {
                TestView()
                    .tabItem {
                        EmptyView()
                    }
                    .tag(1)
                    .onAppear {
                        updateCurrentView(tag: 1)
                    }
                
                MapView()
                    .tabItem {
                        EmptyView()
                    }
                    .tag(2)
                    .onAppear {
                        updateCurrentView(tag: 2)
                    }
            }
            .ignoresSafeArea(.all)
        }
    }
    
    /// 한 번의 터치로 뷰를 전환, 길게 누르면 뚜닷 출력 버튼
    private var tabBarButton: some View {
        ZStack {
            if showTtuDotButton {
                Color.black.opacity(0.5).ignoresSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.changeTabView = true
                            self.showTtuDotButton = false
                            self.ttuDotButtonAngle = -90
                        }
                    }
                VStack {
                    TtuDotButton()
                        .rotationEffect(.degrees(ttuDotButtonAngle))
                        .opacity(showTtuDotButton ? 1 : 0)
                        .onAppear {
                            withAnimation {
                                self.ttuDotButtonAngle = 0
                            }
                        }
                }
                .transition(.move(edge: .bottom))
                
            }
            
            VStack {
                Spacer()
                ZStack {
                    Button(action: {
                        if self.changeTabView == true {
                            self.handleTap()
                        }
                    }) {
                        Image(viewModel.buttonImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 81, height: 42)
                    }
                    .opacity(showTtuDotButton ? 0 : 1)
                    .offset(y: -10)
                    .simultaneousGesture(longPressGesture)
                }
            }
        }
    }
    
    /// 상단 검색 바(Map, Explore 뷰에 따라 달라진다)
    private var searchControl: some View {
        SearchControl(viewModel: viewModel)
    }
    
    
    /// 현재 상태의 반대가 되는 뷰를 메인 뷰로 부르기 위함
    private func handleTap() {
        selectedTab = selectedTab == 1 ? 2 : 1
    }
    
    /// 현재 뷰와 반대가 되는 뷰를 화면에 업데이트 한다.
    /// - Parameter tag: 태그 값에 따라 현재 뷰를 업데이트 한다
    private func updateCurrentView(tag: Int) {
        switch tag {
        case 1 :
            viewModel.currentView = .exploreView
        case 2:
            viewModel.currentView = .mapView
        default :
            print("error")
        }
    }
    
    /// 길게 누르면 뚜닷을 부른다.
    private var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .onChanged{ _ in showTtuDotButton = false }
            .onEnded{ _ in
                changeTabView = false
                showTtuDotButton = true
            }
    }
}

// MARK: - Preview
struct MainViewControl_Previews: PreviewProvider {
    static var previews: some View {
        MainViewControl()
    }
}