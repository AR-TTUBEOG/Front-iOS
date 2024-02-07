//
//  BasketBallGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation

class BasketBallGameViewModel: ObservableObject{
    
    //MARK: - 농구게임 게임 룰 설정
    @Published var timeLimit: Int =  30
    @Published var ballCount: Int = 5
    @Published var successCount: Int = 3
    
    //MARK: - 농구게임 혜택 문구 텍스트 길이
    @Published var benefitsText: String = ""
    
    //MARK: - 농구게임 혜택 쿠폰
    @Published var selectCoupon: Int? = nil
    
    
    //MARK: - 제한 시간 조절
    public func increaseTime() {
        self.timeLimit += 1
    }
    
    public func decreaseTime() {
        if timeLimit > 0{
            self.timeLimit -= 1
        }
    }
    
    //MARK: - 공 개수 조절
    public func increaseBallCount() {
        self.ballCount += 1
    }
    
    public func decreaseBallCount() {
        if ballCount > 0 {
            self.ballCount -= 1
        }
    }
    
    //MARK: - 게임 성공 개수
    public func increaseSuccessCount() {
        self.successCount += 1
    }
    
    public func decreaseSuccessCount() {
        if successCount > 0 {
            self.successCount -= 1
        }
    }
    
    
}
