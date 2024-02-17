//
//  GiftDrawingGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation
import Moya

class GiftDrawingGameViewModel: ObservableObject {
    
    
    //MARK: - API Target
    
    private let authPlugin: AuthPlugin
    let provider: MoyaProvider<GameManagerService>
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<GameManagerService>(plugins: [authPlugin])
    }
    
    var giftModel: GifttModel?
    @Published var storeId: Int = 0
    //MARK: 농구게임 게임 룰 설정
    @Published var timeLimit: TimeInterval = 30
    @Published var giftCount: Int = 5
    
    //MARK: - 선물뽑기 혜택 문구 텍스트 길이
    @Published var benefitsText: String = ""
    
    //MARK: - 선물뽑기 혜택 쿠폰
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
    
    //MARK: - 선물 개수 조절
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
    
    //MARK: - 데이터 전달
    
    /// 시간 초 단위로 변경
    /// - Parameter timeInterval: 변경 하고자 하는 시간 단위
    /// - Returns: 시간단위 값
    private func formatTimeInterval(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func matchData() {
        
        let timeString = formatTimeInterval(self.timeLimit)
        print("선물게임 storeId: \(storeId)")

        
        giftModel = GifttModel(timeLimit: timeString, giftCount: self.giftCount, benefitContent: self.benefitsText, benefitType: {
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
        
        if let giftModel = self.giftModel {
            
            provider.request(.gift(benefitRequest: giftModel, token: accessToken)) { result in
                switch result {
                case .success(let response):
                    print(String(data: response.data, encoding: .utf8) ?? "Invalid response")
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseGiftModel.self, from: response.data)
                        print("농구 게임 정보 전달 성공 : \(decodedData)")
                    } catch {
                        print("선물뽑기 반응 error : \(error)")
                    }
                case .failure(let error):
                    print("선물뽑기 요청 error : \(error)")
                }
            }
        }
    }
    
    func finishSendAPI() {
        print("----------선물게임 정보 전달---------")
        matchData()
        sendData()
        print("------------------------======---")
    }
    
}
