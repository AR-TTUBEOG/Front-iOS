//
//  Market.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import SwiftUI

struct MarketPageContent: View {
    //MARK: - Propery
    @State private var marketName = ""
    @ObservedObject var viewModel = MarketViewModel()
    
    ////MARK: - TextFieldShame
    private let horizontalPadding: CGFloat = 15
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            viewFlow
        }
    }
    
    //MARK: - MarketPageContent
    
    @ViewBuilder
    private var viewFlow: some View {
        switch viewModel.currentPageIndext {
        case 0:
            firstView
        case 1:
            secondView
        default:
            EmptyView()
        }
    }
    
    //MARK: - MarketFirstView
    
    private var firstView: some View {
        VStack(alignment: .leading, spacing: 35) {
            CustomTitleView(titleText: "업체의 이름을 알려주세요",
                            highlightText: ["이름"],
                            subtitleText: "지도에 등록되는 매장의 이름이에요!",
                            titleHeight: 36,
                            spacing: 9,
                            textAlignment: .leading,
                            frameAlignment: .leading)
            
            CustomTextField(text: $viewModel.firstMarketName,
                            placeholder: "예) 죠스 떡볶이 중앙대점",
                            maxWidth: 340,
                            maxHeight: 45,
                            onSearch: {}
            )
        }
    }
    
    //MARK: - SecondView
    
    /// 두 번째 주소검색 커스텀 텍스트 필드
    private var secondAddressInputTextField: some View {
        CustomTextField(text: $viewModel.secondAddressName,
                        placeholder: "주소를 검색해주세요.",
                        trailingHorizontalPadding: horizontalPadding + 35,
                        maxWidth: 275,
                        maxHeight: 45,
                        onSearch: {})
    }
    
    /// 두 번째 상세 주소 입력
    private var secondDetailAddressInputTextField: some View {
        CustomTextField(text: $viewModel.secondDetailAddress,
                        placeholder: "상세주소를 입력해주세요.",
                        trailingHorizontalPadding: horizontalPadding + 35,
                        maxWidth: 332,
                        maxHeight: 45,
                        onSearch: {})
    }
    
    private var secondBottomAddressInputs: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 8) {
                secondAddressInputTextField
                Button(action: {
                    print("hello")
                }, label: {
                    Icon.searchAddress.image
                        .resizable()
                        .frame(maxWidth: 48, maxHeight: 45)
                })
            }
            secondDetailAddressInputTextField
        }
    }
    
    private var secondView: some View {
        VStack(alignment: .leading, spacing: 35) {
            CustomTitleView(titleText: "업체의 위치를 알려주세요",
                            highlightText: ["위치"],
                            subtitleText: "매장의 정확한 위치를 남겨주세요!",
                            titleHeight: 36,
                            textAlignment: .leading,
                            frameAlignment: .topLeading
            )
            
            secondBottomAddressInputs
        }
    }
    
    //MARK: - thirdView
//    
//    private var choicMarketType: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            CustomTextField(text: $viewModel.thirdMarketTypeName,
//                            placeholder: "업종을 골라주세요",
//                            maxWidth: 332,
//                            maxHeight: 45,
//                            onSearch: {})
//            HStack(spacing: 7) {
//                
//            }
//        }
//    }
}

#Preview {
    MarketPageContent()
}
