//
//  CouponModel.swift
//  ttubeokAR
//
//  Created by Subeen on 1/16/24.
//

import Foundation

protocol CouponModel {
    func execute()
}

struct Coupon: Hashable {    // 제목, 시간, 날짜, 선택여부
    var type: CouponType
//    var time: Date
//    var day: Date
    var time: String
    var day: String
    var used: Bool
    var title: String
    var content: String
    
    enum CouponType: String {
        case onePlusOne = "1+1"
        case free = "Free"
        case percent = "%"
        
        var name: String {
            return self.rawValue
        }
    }
}


