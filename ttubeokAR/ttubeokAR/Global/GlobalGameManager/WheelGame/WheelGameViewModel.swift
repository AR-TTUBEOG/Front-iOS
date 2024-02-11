//
//  WheelGameRules.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation

class WheelGameViewModel: ObservableObject {
    
    static let share = WheelGameViewModel()
    
    @Published var wheelGameSetting: [WheelGameSetting]
    @Published var texts: [String] = Array(repeating: "하하호호", count: 4)
    @Published var activePopoverIndex: Int? = nil
    
    init() {
        wheelGameSetting = [
            WheelGameSetting(option: "상품"),
            WheelGameSetting(option: "꽝"),
            WheelGameSetting(option: "상품"),
            WheelGameSetting(option: "꽝")
        ]
        
        
    }
}
