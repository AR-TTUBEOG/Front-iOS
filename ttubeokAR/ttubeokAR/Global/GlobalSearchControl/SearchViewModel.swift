//
//  SearchViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI


class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedButtonIndex: Int? = 0
    @Published var buttons: [SearchButtonModel] = []
    
    
    //TODO: - 탭바로 뷰 전환시 값 변경 되도록 해야함.
    var currentView: CurrentView = .mapView {
        didSet {
            setupButton()
        }
    }
    
    var logoImage: Image {
        switch currentView {
        case .mapView:
            return Image("book")
        case .exploreView:
            return Image("logo")
        }
    }
    
    var imageSize: CGSize {
        switch currentView {
        case .exploreView:
            return CGSize(width: 43, height: 31)
        case .mapView:
            return CGSize(width: 26, height: 23.21)
        }
    }
    
    init() {
        setupButton()
    }
    
    
    private func setupButton() {
        switch currentView {
        case  .mapView:
            self.buttons = [
                SearchButtonModel(title: "모든 산책로", buttonImage: "", action: self.selectPromenade),
                SearchButtonModel(title: "산책로", buttonImage: "trail", action: self.selectPromenade),
                SearchButtonModel(title: "음식점", buttonImage: "restaurant", action: self.selectRestaurant),
                SearchButtonModel(title: "카페", buttonImage: "drink", action: self.selectCafe)
            ]
            
        case .exploreView:
            self.buttons = [
                SearchButtonModel(title: "전체 선택", buttonImage: "", action: self.selectAll),
                SearchButtonModel(title: "최신순", buttonImage: "", action: self.sortByLatest),
                SearchButtonModel(title: "거리순", buttonImage: "", action: self.sortByDistance),
                SearchButtonModel(title: "추천순", buttonImage: "", action: self.sortByRecommendation),
                SearchButtonModel(title: "방명록순", buttonImage: "", action: self.sortByGuestBook)
            ]
        }
    }
    
    
    public func buttonSelection(at index: Int) {
        if selectedButtonIndex == index {
            selectedButtonIndex = nil
        } else {
            selectedButtonIndex = index
        }
    }
    
    // MARK: - TODO
    /*
     추후에 하단 함수의 기능을 다시 재작성하여 구현할것!
     */
    
    public func selectAll(){
        print("전체 선택")
    }
    
    public func sortByLatest(){
        print("최신순 정렬")
    }
    
    public func sortByDistance(){
        print("거리순 정렬")
    }
    
    public func sortByRecommendation(){
        print("추천순 정렬")
    }
    
    public func sortByGuestBook(){
        print("방명록 정렬")
    }
    
    //MARK: - MapView 간편 검색 버튼
    
    public func selectPromenade(){
        print("산책로")
    }
    
    public func selectRestaurant(){
        print("식당")
    }
    
    public func selectCafe(){
        print("카페")
    }
}
