//
//  TabBarButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/10/24.
//

import SwiftUI

struct MainTabBarControl: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var selectedTab = 1
    @State private var showTtuDotButton = false
    @State private var changeTabView = true
    @State private var screenSize: CGSize = .zero
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
    
    private var searchControl: some View {
        SearchControl(viewModel: viewModel)
    }
    
    private func handleTap() {
        selectedTab = selectedTab == 1 ? 2 : 1
    }
    
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
    
    private var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .onChanged{ _ in showTtuDotButton = false }
            .onEnded{ _ in
                changeTabView = false
                showTtuDotButton = true
            }
    }
}


struct MainTabBarControl_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarControl()
    }
}
