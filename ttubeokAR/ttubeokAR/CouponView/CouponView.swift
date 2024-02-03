//
//  CouponView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/16/24.
//

import SwiftUI

struct CouponView: View {
    @EnvironmentObject private var couponViewModel: CouponViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                TitleView()
                CouponListView()
            }
            .environmentObject(couponViewModel)
        }
    }
    
    private struct TitleView: View {
        @EnvironmentObject private var couponViewModel: CouponViewModel
        fileprivate var body: some View {
            VStack {
                NavigationBar(isDisplayLeadingBtn: true,
                              title: "내 쿠폰")
                
                HStack {
                    Text("\(couponViewModel.countsOfCoupons)개")
                        .font(.sandol(type: .regular, size: 15))
                        .padding(.leading, 38)
                     Spacer()
                    filterBtn()
                    
                }
                
            }
        }
    }
    
    private struct filterBtn: View {
        @EnvironmentObject private var couponViewModel: CouponViewModel

        fileprivate var body: some View {
            Menu {
                ForEach(CouponViewModel.FilterType.allCases, id: \.self) { item in
                    Button {
                        couponViewModel.filterType = item
                    } label: {
                        Label {
                            Text(item.title)
                        } icon: {
                            if couponViewModel.filterType == item {
                                Icon.chevronDown.image
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(couponViewModel.filterType.title)
                    Icon.chevronDown.image
                }
                .foregroundStyle(.white)
                .font(.sandol(type: .regular, size: 13))
                .padding(.trailing, 13)
                
            }
        }
    }
    
    private struct CouponListView: View {
        @EnvironmentObject private var couponViewModel: CouponViewModel
        @State private var showingCoupon = false
        
        fileprivate var body: some View {
            VStack {
                ScrollView() {
                    VStack (spacing: 27) {
                        ForEach(couponViewModel.coupons, id: \.self) { coupon in
                            // 쿠폰 셀 뷰 호출
                            CouponCellView(showingCoupon: $showingCoupon, coupon: coupon)
                        }
                    }
                    .padding(.horizontal, 15)
                }
                .scrollIndicators(.hidden)
            }
            .overlay {
                if (showingCoupon) {
                    ZStack {
                        Color.black.opacity(0.5)
                            .onTapGesture {
                                showingCoupon = false
                            }
                        Icon.couponBackground.image
                            .resizable()
                            .scaledToFit()
                        
                            .padding(.horizontal, 60)
                            .padding(.bottom, 110)
                    }
                    
                }
            }
        }
    }

    private struct CouponCellView: View {
        @EnvironmentObject private var couponViewModel: CouponViewModel
        @Binding var showingCoupon: Bool
        private var coupon: Coupon
        
        init(showingCoupon: Binding<Bool>, coupon: Coupon) {
            self._showingCoupon = showingCoupon
            self.coupon = coupon
        }
        
        fileprivate var body: some View {
            
            Button {
                showingCoupon = true
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.52, green: 0.54, blue: 0.92), location: 0.00),
                                    Gradient.Stop(color: .white.opacity(0.9), location: 1.00),
                                    Gradient.Stop(color: Color(red: 0.25, green: 0.18, blue: 0.5), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.3, y: 0.33),
                                endPoint: UnitPoint(x: -0.2, y: 1.43)
                            )
                        )
                        .frame(height: 160)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(coupon.type.rawValue)
    //                            .font(.sandol(type: .extraBold, size: 40))
                            Text(coupon.title)
                                .font(.sandol(type: .bold, size: 25))
                            Text(coupon.content)
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 15)
                    .foregroundColor(.white)
                }
                
            }
            
        }
    }

    private struct CouponPopupView: View {
        private var coupon: Coupon
        
        init(coupon: Coupon) {
            self.coupon = coupon
        }
        
        fileprivate var body: some View {
            ZStack {
                Color.black.opacity(0.2)
                Icon.couponBackground.image
            }
        }
    }
    
}

#Preview {
    CouponView()
        .environmentObject(CouponViewModel(filterType: .latest))
}
