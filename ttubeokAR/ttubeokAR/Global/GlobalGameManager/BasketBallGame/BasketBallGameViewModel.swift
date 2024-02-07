//
//  BasketBallGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation

class BasketBallGameViewModel: ObservableObject{
    
    //MARK: 농구게임 게임 룰 설정
    @Published var timeLimit: Int
    @Published var ballCount: Int = 5
    @Published var successCount: Int = 3
    
    init(timeLimit: Int = 30) {
        self.timeLimit = timeLimit
    }
}
