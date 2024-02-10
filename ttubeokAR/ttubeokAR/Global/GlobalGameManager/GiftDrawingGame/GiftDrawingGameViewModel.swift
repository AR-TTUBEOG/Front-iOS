//
//  GiftDrawingGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation

class GiftDrawingGameViewModel: ObservableObject {
    
    //MARK: 농구게임 게임 룰 설정
    @Published var timeLimit: Int = 0
    @Published var giftCount: Int = 5
    
    //MARK: - 제한 시간 조절
    public func increaseTime() {
        if self.timeLimit < 60{
            self.timeLimit += 1
        }
    }
    
    public func decreaseTime() {
        if self.timeLimit > 0 {
            self.timeLimit -= 1
        }
    }
    
    //MARK: - 공 개수 조절
    public func increaseGifCount() {
        if self.giftCount < 5 {
            self.giftCount += 1
        }
    }
    
    public func decreaseGiftCount() {
        if self.giftCount > 1 {
            self.giftCount -= 1
        }
    }
    
}
