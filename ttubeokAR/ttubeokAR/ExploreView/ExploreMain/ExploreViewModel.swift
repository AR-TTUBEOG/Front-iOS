//
//  ExploreViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    
    //MARK: - Property
    @Published var isFavorited: Bool = false
    static var ExploreViweModel = ExploreViewModel()
    
    // MARK: - ChangeExploreView
    
    var favoriteImageName: String {
          return isFavorited ? "Vector2" : "Vector"
      }
    
    
    
    
    // MARK: - Function
    public func toggleFavorite() {
            isFavorited.toggle()
            if isFavorited {
                print("북마크 버튼이 눌렸습니다.")
            } else {
                print("북마크 취소 버튼이 눌렸습니다.")
            }
        }
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    func getPlaceTypeText(for place: Place?) -> String {
        guard let place = place else {
            return "Unknown"
        }
        return "SomeString"
    }


  
}
