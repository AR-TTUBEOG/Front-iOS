//
//  GiftDrawingGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation

class GiftDrawingGameViewModel: ObservableObject {
    
    //MARK: 농구게임 게임 룰 설정
    var timeLimit: Int
    @Published var giftCount: Int = 5
    
    init(timeLimit: Int = 30) {
        self.timeLimit = timeLimit
    }
}
