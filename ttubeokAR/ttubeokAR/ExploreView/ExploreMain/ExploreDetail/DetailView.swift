//
//  DetailView.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/26/24.
//

import Foundation



//방명록 작성 버튼
class DetailView: ObservableObject {
    
    
    func GuestVisitAction() {
        print("방문하기를 눌렀습니다.")
    }
    
    func GuestBookAction() {
        print("방명록을 작성합니다.")
    }
    
    func performButton1Action() {
           // 버튼 1이 눌렸을 때의 동작을 여기에 추가
           print("Button 1 Clicked in DetailView!")
       }

    func performButton2Action() {
           // 버튼 2가 눌렸을 때의 동작을 여기에 추가
           print("Button 2 Clicked in DetailView!")
       }

    func performButton3Action() {
           // 버튼 3이 눌렸을 때의 동작을 여기에 추가
           print("Button 3 Clicked in DetailView!")
       }
  
    
    
}
