//
//  SearchViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI


class SearchViewModel: ObservableObject {
    
    //MARK: - Property
    @Published var searchType: SearchType = .all
    @Published var searchText: String = ""
    @Published var selectedButtonIndex: Int? = 0
    @Published var buttons: [SearchButtonModel] = []
    @Published var currentView: TabBarModel = .exploreView {
        didSet {
            setupButton()
        }
    }
    var exploreViewModel: ExploreViewModel?
    
    // MARK: - ChangeMainView
    var logoImage: Image {
        switch currentView {
        case .mapView:
            return Image("book")
            
        case .exploreView:
            return Icon.searchLogo.image
        }
    }
    
    var buttonImage: String {
        switch currentView {
        case .exploreView:
            return "MapTabButton"
        case .mapView:
            return "ExploreTabButton"
        }
    }
    
    var imageSize: CGSize {
        switch currentView {
        case .exploreView:
            return CGSize(width: 44, height: 40)
        case .mapView:
            return CGSize(width: 26, height: 26)
        }
    }
    
    init() {
        setupButton()
    }
    
    // MARK: - Function
    
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
                SearchButtonModel(title: "추천순", buttonImage: "", action: self.sortByRecommendation)
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
    
    public func getTextFieldValue() -> String {
        return searchText
    }
    
    
    
    //MARK: - SearchView 버튼
    
    var searchTypeChanged: ((SearchType) -> Void)?
    
    public func updateSearchType(_ newType: SearchType) {
        searchType = newType
        searchTypeChanged?(newType)
    }
    
    public func search() {
        print("검색합니다.")
    }
    
    public func selectAll(){
        exploreViewModel?.currentSearchType = .all
        print("전체 검색 버튼 누름")
    }
    
    public func sortByLatest(){
        exploreViewModel?.currentSearchType = .latest
        print("최근 검색 버튼 누름")
    }
    
    public func sortByDistance(){
        exploreViewModel?.currentSearchType = .distance
        print("거리순 검색 버튼 누름")
    }
    
    public func sortByRecommendation(){
        exploreViewModel?.currentSearchType = .recommended
        print("추천순 검색 버튼 누름")
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
