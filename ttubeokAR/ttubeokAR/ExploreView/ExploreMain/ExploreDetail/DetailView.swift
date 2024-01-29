//
//  DetailView.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/26/24.
//

import Foundation



class DetailView: ObservableObject {
    // MARK: - Property
    @Published var isFavorited: Bool = false
    
    // MARK: - Function
    func GuestVisitAction() {
        print("방문하기를 눌렀습니다.")
    }
    
    func GuestBookAction() {
        print("방명록을 작성합니다.")
    }
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    var favoriteImageName: String {
          return isFavorited ? "pressedheart" : "unpressedheart"
      }
    
    public func toggleFavorite() {
            isFavorited.toggle()
            if isFavorited {
                print("북마크 버튼이 눌렸습니다.")
            } else {
                print("북마크 취소 버튼이 눌렸습니다.")
            }
        }
    
    
    
}
