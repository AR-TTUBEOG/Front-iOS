//
//  WheelGamePickerMenu.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/11/24.
//

import Foundation

enum WheelGameSetting {
    case goods
    case boom
    
    init(option: String) {
        switch option {
        case "상품":
            self = .goods
        case "꽝":
            self = .boom
        default:
            self = .goods
        }
    }
}
