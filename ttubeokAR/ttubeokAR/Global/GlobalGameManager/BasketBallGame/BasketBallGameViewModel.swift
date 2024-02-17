//
//  BasketBallGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation
import Moya

class BasketBallGameViewModel: ObservableObject {
    
    //MARK: - API Target
    private let authPlugin: AuthPlugin
    private let provider: MoyaProvider<GameManagerService>
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<GameManagerService>(plugins: [authPlugin])
    }
    
    var basketBallModel: BasketBallModel?
    @Published var storeId: Int = 0
    
    //MARK: - 농구게임 게임 룰 설정
    @Published var timeLimit: TimeInterval =  30
    @Published var ballCount: Int = 5
    @Published var successCount: Int = 3
    
    //MARK: - 농구게임 혜택 문구 텍스트 길이
    @Published var benefitsText: String = ""
    
    //MARK: - 농구게임 혜택 쿠폰
    @Published var selectCoupon: Int? = nil
    
    //MARK: - 제한 시간 조절
    public func increaseTime() {
        if self.timeLimit < 60{
            self.timeLimit += 1
        }
    }
    
    public func decreaseTime() {
        if self.timeLimit > 15 {
            self.timeLimit -= 1
        }
    }
    
    //MARK: - 공 개수 조절
    public func increaseBallCount() {
        if self.ballCount < 5 {
            self.ballCount += 1
        }
    }
    
    public func decreaseBallCount() {
        if self.ballCount > 1 {
            self.ballCount -= 1
        }
    }
    
    //MARK: - 게임 성공 개수
    public func increaseSuccessCount() {
        if self.successCount < 5 {
            self.successCount += 1
        }
    }
    
    public func decreaseSuccessCount() {
        if self.successCount > 1 {
            self.successCount -= 1
        }
    }
    
    //MARK: - 데이터 전달
    
    private func formatTimeInterval(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    private func matchData() {
        
        let timeString = formatTimeInterval(self.timeLimit)
        print("농구게임 storeId: \(storeId)")
        
        basketBallModel = BasketBallModel(storeId: self.storeId,
                                          timeLimit: timeString,
                                          ballCount: self.ballCount,
                                          successCount: self.successCount,
                                          benefitContent: self.benefitsText,
                                          benefitType: {
            switch selectCoupon {
            case 1:
                return "SALE"
            case 2:
                return "PLUS"
            case 3:
                return "GIFT"
            default:
                return "NONE"
            }
        }()
        )
    }
    
    private func sendData() {
        guard let accessToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("accessToken")
            return
        }
        
        if let basketBallModel = basketBallModel {
            provider.request(.basketBall(benefitRequest: basketBallModel, token: accessToken)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseBasketBallModel.self, from: response.data)
                        print("농구 게임 정보 전달 성공 : \(decodedData)")
                    } catch {
                        print("농구 게임 반응 error : \(error)")
                    }
                case .failure(let error):
                    print("농구게임 요청 error : \(error)")
                }
            }
        }
    }
    
    //MARK: - 완료 버튼 API 전송
    public func finishSendAPI() {
        print("----------농구게임 정보 전달---------")
        matchData()
        sendData()
        print("------------------------======---")
    }
}
