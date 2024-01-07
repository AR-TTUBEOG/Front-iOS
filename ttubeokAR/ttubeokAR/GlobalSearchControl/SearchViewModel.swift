//
//  SearchViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var  searchText: String = ""
    @Published var selectedButtonIndex: Int? = 0
    @Published var buttons: [SearchButtonModel] = []
    
    init() {
        self.buttons = [
            SearchButtonModel(title: "전체 선택", action: self.selectAll),
            SearchButtonModel(title: "최신순", action: self.sortByLatest),
            SearchButtonModel(title: "거리순", action: self.sortByDistance),
            SearchButtonModel(title: "추천순", action: self.sortByRecommendation)
        ]
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
}
