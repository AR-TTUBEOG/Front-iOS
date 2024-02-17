//
//  WheelGameRules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation
import Moya

class WheelGameViewModel: ObservableObject, FinishButtonProtocol {
    
//    static let share = WheelGameViewModel()
    let provider = MoyaProvider<GameManagerService>()
    var wheelModel: RouletteModel?
    
    //MARK: - 원판 상품 설정
    @Published var wheelGameSetting: [WheelGameSetting]
    @Published var texts: [String] = Array(repeating: "", count: 4)
    @Published var activePopoverIndex: Int? = nil
    
    //MARK: - 혜택 쿠폰 선택
    @Published var selectCoupon: Int? = nil
    
    init() {
        wheelGameSetting = [
            WheelGameSetting(option: "상품"),
            WheelGameSetting(option: "꽝"),
            WheelGameSetting(option: "상품"),
            WheelGameSetting(option: "꽝")
        ]
    }
    
    //MARK: - API 전달
    
    private func matchData() {
        wheelModel = RouletteModel(benefitType: {
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
                                }(),
                                   options: self.texts)
    }
    
    private func sendData() {
        guard let accessToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("accessToken")
            return
        }
        
        if let wheelModel = wheelModel {
            provider.request(.roulette(benefitRequest: wheelModel, token: accessToken)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseRouletteModel.self, from: response.data)
                        print(decodedData)
                    } catch {
                        print("돌림판 게임 반응 error : \(error)")
                    }
                case .failure(let error):
                    print("요청 error : \(error)")
                }
            }
        }
    }
    
    func finishSendAPI() {
        matchData()
        sendData()
    }
}
