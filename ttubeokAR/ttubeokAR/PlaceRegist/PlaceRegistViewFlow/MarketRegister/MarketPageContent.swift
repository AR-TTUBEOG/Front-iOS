//
//  Market.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import SwiftUI

struct MarketPageContent: View {
    
    //MARK: - Propery
    @State private var isSelected: MarketTypeName = .none
    
    //MARK: - ViewModel
    @ObservedObject var viewModel: MarketViewModel
    //MARK: - TextFieldShame
    private let horizontalPadding: CGFloat = 15
    
    //MARK: - FifthPaddingShame
    private let fifthHorizontalPadding: CGFloat = 16
    private let fifthVerticalPadding: CGFloat = 12
    
    //MARK: - Body
    var body: some View {
            viewFlow
    }
    
    //MARK: - MarketPageContent
    
    @ViewBuilder
    private var viewFlow: some View {
        switch viewModel.currentPageIndex {
        case 0:
            firstView
        case 1:
            secondView
        case 2:
            thirdView
        case 3:
            ScrollView {
                fourthTitleView
            }
            .scrollIndicators(.hidden)
        case 4:
            ScrollView {
                fifthView
            }
            .scrollIndicators(.hidden)
        case 5:
            sixthView
            .scrollIndicators(.hidden)
        default:
            EmptyView()
        }
    }
    
    //MARK: - MarketFirstView
    
    /// 첫 번째 뷰
    private var firstView: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomTitleView(titleText: "업체의 이름을 알려주세요",
                            highlightText: ["이름"],
                            subtitleText: "지도에 등록되는 매장의 이름이에요!",
                            titleHeight: 36,
                            spacing: 9,
                            textAlignment: .leading,
                            frameAlignment: .leading)
            
            CustomTextField(text: $viewModel.firstMarketName,
                            placeholder: "예) 죠스 떡볶이 중앙대점",
                            maxWidth: 320,
                            maxHeight: 38,
                            onSearch: {}
            )
        }
        .frame(width: 360)
    }
    
    //MARK: - SecondView
    
    
    /// 두 번째 뷰
    private var secondView: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomTitleView(titleText: "업체의 위치를 알려주세요",
                            highlightText: ["위치"],
                            subtitleText: "매장의 정확한 위치를 남겨주세요!",
                            titleHeight: 36,
                            spacing: 12,
                            textAlignment: .leading,
                            frameAlignment: .topLeading
            )
            
            InputAddressView(viewModel: viewModel)
        }
        .frame(width: 360)
    }
    
    //MARK: - thirdView
    
    /// 세 번째 타이틀 뷰
    private var thirdTitleView: some View {
        CustomTitleView(titleText: "업종을 알려주세요",
                        highlightText: ["업종"],
                        subtitleText: "방문객에게 어떤 서비스 제공을 하는지 알려주세요",
                        titleHeight: 36,
                        textAlignment: .leading,
                        frameAlignment: .leading
        )
        .disabled(true)
    }
    
    /// 세 번째 뷰 장소 선택 버튼
    private var choicMarketType: some View {
        VStack(alignment: .leading, spacing: 13) {
            CustomTextField(text: $viewModel.thirdMarketTypeName,
                            placeholder: "업종을 골라주세요.",
                            maxWidth: 320,
                            maxHeight: 38,
                            onSearch: {})
            HStack(spacing: 7) {
                SelectMarketType(marketType: .restaurant,
                                 isSelected: Binding(
                                    get : { self.isSelected == .restaurant },
                                    set : { if $0 { self.isSelected = .restaurant }}
                                 ),
                                 selectedMarketType: $viewModel.thirdMarketTypeName)
                SelectMarketType(marketType: .cafe,
                                 isSelected: Binding(
                                    get : { self.isSelected == .cafe },
                                    set : { if $0 { self.isSelected = .cafe }}
                                 ),
                                 selectedMarketType: $viewModel.thirdMarketTypeName)
            }
        }
    }
    
    /// 세 번째 뷰
    private var thirdView:some View {
        VStack(alignment: .leading, spacing: 20) {
            thirdTitleView
            choicMarketType
        }
        .frame(width: 360)
    }
    
    //MARK: - fourthView
    
    private var fourthTitleView: some View {
        CustomTitleView(titleText: "소개와 사진 등 \n매장 정보를 입력해보세요",
                        highlightText: ["정보"],
                        subtitleText: "정보를 입력해야 방문객에게 장소가 보여요",
                        titleWidth: 355,
                        titleHeight: 80,
                        textAlignment: .center,
                        frameAlignment: .center)
    }
    
    //MARK: - fifthView
    
    /// 다섯 번째 타이틀 뷰
    private var fifthTitleView: some View {
        CustomTitleView(titleText: "업체를 소개해주세요",
                        highlightText: ["소개"],
                        subtitleText: "나중에 언제든지 변경할 수 있으니, 걱정하지 마세요",
                        titleHeight: 36,
                        textAlignment: .leading,
                        frameAlignment: .leading)
    }
    
    /// 다섯 번째 설명 텍스트 필드
    private var fifthMarketDescription: some View {
        ZStack(alignment: .bottomTrailing) {
            CustomTextField(text: $viewModel.fifthMarketDescription,
                            placeholder: "예) 함께하는 사람들과 돈까스 한입 하고 가세요.",
                            fontSize: 15,
                            leadingHorizontalPadding: fifthHorizontalPadding,
                            trailingHorizontalPadding: fifthHorizontalPadding,
                            verticalPadding: fifthVerticalPadding,
                            maxWidth: 300,
                            maxHeight: 90,
                            onSearch: {},
                            alignment: .topLeading,
                            axis: .vertical,
                            maxLength: 50
            )
            
            Text("\(viewModel.fifthMarketDescription.count) / 50")
                .frame(width: 48, height: 30, alignment: .center)
                .font(.sandol(type: .regular, size: 11))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textPink)
        }
    }
    
    /// 다섯 번째 안내문 뷰
    private var fifthInformationNotice: some View {
        HStack(spacing: 9) {
            Icon.lightOn.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 27, height: 27)
            Text("입력한 정보는 이렇게 화면에 나와요.")
                .font(.sandol(type: .medium, size: 12))
                .foregroundStyle(.textPink)
                .frame(width: 268, height: 16, alignment: .leading)
            
        }
        .frame(width: 324, height: 27, alignment: .leading)
    }
    
    /// 다섯 번째 예시 사진
    private var fifthExampleImage: some View {
        Icon.exampleMarket.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 340, height: 280)
    }
    
    /// 다섯 번째 뷰
    private var fifthView: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 20) {
                fifthTitleView
                fifthMarketDescription
                
                VStack(alignment: .leading, spacing: 24) {
                    fifthInformationNotice
                    fifthExampleImage
                }
            }
        }
        .frame(maxWidth: 360)
    }
    
    //MARK: - sixthView
    
    /// 여섯 번째 안내문 뷰
    private var sixthInformationNotice: some View {
        HStack(spacing: 9) {
            Icon.lightOn.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 27, maxHeight: 27)
            Text("등록된 사진은 이렇게 보여요.")
                .font(.sandol(type: .medium, size: 12))
                .foregroundStyle(.textPink)
                .frame(maxWidth: 268, maxHeight: 16, alignment: .leading)
            
        }
        .frame(maxWidth: 304, maxHeight: 27, alignment: .leading)
    }
    
    /// 여섯 번째 예시 사진
    private var sixthExampleImage: some View {
        Icon.exampleMarket2.image
            .resizable()
            .frame(width: 340, height: 240)
    }
    
    private var sixthTitle: some View {
        CustomTitleView(titleText: "업체사진을 등록해주세요",
                        highlightText: ["사진", "등록"],
                        subtitleText: "방문객은 배경 사진을 보고 매장을 파악해요. \n사진은 이후 변경할 수 있지만 한 장은 필수 등록이에요!",
                        titleHeight: 36,
                        subtitleHeight: 60,
                        textAlignment: .leading,
                        frameAlignment: .topLeading)
        
    }
    
    /// 여섯 번째 뷰
    private var sixthView: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 2) {
                sixthTitle
                ImageSelectionButton(viewModel: viewModel)
            }
            VStack(alignment: .leading, spacing: 14) {
                sixthInformationNotice
                sixthExampleImage
            }
        }
        .frame(width: 360)
    }
}
