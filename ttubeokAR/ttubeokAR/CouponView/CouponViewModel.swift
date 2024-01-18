//
//  CouponViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 1/16/24.
//


import Foundation

class CouponViewModel: ObservableObject {
    @Published var coupons: [Coupon]
    @Published var filterType: FilterType
    
    var countsOfCoupons: Int {
        return coupons.count
    }
    
    enum FilterType: CaseIterable {
        case latest, date
        
        var title: String {
            switch self {
            case .latest:
                return "최신순"
            case .date:
                return "사용기간순"
            }
        }
    }
    
    init(
        coupons: [Coupon] = [
            Coupon(type: .onePlusOne, time: "11:59", day: "2024.10.31", used: false, title: "하나 사면 하나 더 제공 쿠폰", content: "매장 방문시 제공되는 이벤트 쿠폰"),
            Coupon(type: .free, time: "11:59", day: "2024.10.31", used: true, title: "하나 사면 하나 더 제공 쿠폰", content: "매장 방문시 제공되는 이벤트 쿠폰"),
            Coupon(type: .percent, time: "11:59", day: "2024.10.31", used: true, title: "하나 사면 하나 더 제공 쿠폰", content: "매장 방문시 제공되는 이벤트 쿠폰")
        ],
        filterType: FilterType
    ) {
        self.coupons = coupons
        self.filterType = filterType
    }
}

extension CouponViewModel {
    
    // 정렬 버튼 탭
    func sortBtnTapped() {
        
    }
}




