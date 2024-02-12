//
//  WheelGameRules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation

class WheelGameViewModel: ObservableObject, FinishButtonProtocol {
    
    static let share = WheelGameViewModel()
    
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
    func finishSendAPI() {
        print("hello")
    }
}
