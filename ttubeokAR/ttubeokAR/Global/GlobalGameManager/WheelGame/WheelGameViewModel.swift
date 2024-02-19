//
//  WheelGameRules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation
import Moya

class WheelGameViewModel: ObservableObject {
    
    //MARK: - API Target
    private let authPlugin: AuthPlugin
    let provider: MoyaProvider<GameManagerService>

    var wheelModel: RouletteModel?
    @Published var storeId: Int = 0
    
    //MARK: - 원판 상품 설정
    @Published var wheelGameSetting: [WheelGameSetting]
    @Published var texts: [String] = Array(repeating: "", count: 4)
    @Published var activePopoverIndex: Int? = nil
    
    //MARK: - 혜택 쿠폰 선택
    @Published var selectCoupon: Int? = nil
    
    init() {
        
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.provider = MoyaProvider<GameManagerService>(plugins: [authPlugin])
        
        wheelGameSetting = [ 
            WheelGameSetting(option: "상품"),
            WheelGameSetting(option: "상품"),
            WheelGameSetting(option: "상푸"),
            WheelGameSetting(option: "상품")
        ]
        
        texts = ["키링 당첨!!", "꽝입니다!!!", "스티커 당첨!!", "박수 당첨!!"]
    }
    
    //MARK: - API 전달
    
    private func matchData() {
        wheelModel = RouletteModel(storeId: self.storeId,
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
                        print("회전판 게임 정보 전달 성공 : \(decodedData)")
                    } catch {
                        print("돌림판 게임 반응 error : \(error)")
                    }
                case .failure(let error):
                    print("돌림판 요청 error : \(error)")
                }
            }
        }
    }
    
    func finishSendAPI() {
        print("----------회전판 정보 전달---------")
        matchData()
        sendData()
        print("------------------------======---")
    }
}
