//
//  WalkwayPageContent.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import SwiftUI

struct WalkwayPageContent: View {
    //MARK: - Property
    @ObservedObject var viewModel: WalkwayViewModel
    @State private var walkWayName = ""
    
    //MARK: - TextFieldShame
    private let horizontalPadding: CGFloat = 15
    
    //MARK: - FourthPaddingShame
    private let fourthHorizontalPadding: CGFloat = 16
    private let fourthVerticalPadding: CGFloat = 12
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.background
            viewFlow
        }
    }
    
    //MARK: - WalkwayPageContentView
    
    @ViewBuilder
    private var viewFlow: some View {
        switch viewModel.currentPageIndex {
        case 0:
            firstView
        case 1:
            secondeView
        case 2:
            thirdView
        case 3:
            fourthView
            //        case 4:
            //            EmptyView()
        default:
            EmptyView()
        }
    }
    
    //MARK: - WalkwayFirstView
    
    /// 첫 번째장소이름 커스텀 텍스트 필드
    private var firstPlaceInputTextField: some View {
        CustomTextField(text: $viewModel.firstPlaceName,
                        placeholder: "예) 낙산공원",
                        maxWidth: 345,
                        maxHeight: 45,
                        onSearch: {})
    }
    
    
    /// 첫 번째 안내글 뷰
    private var firstView: some View {
        VStack(alignment: .leading, spacing: 10) {
            CustomTitleView(titleText: "산책스팟의 이름을 알려주세요",
                      highlightText: ["이름"],
                      subtitleText: "지도에 등록되는 산책로의 이름이에요!",
                      titleHeight: 36,
                      textAlignment: .leading,
                      frameAlignment: .topLeading
            )
            firstPlaceInputTextField
        }
    }
    
    //MARK: - WalkwaySecondView
    
    /// 두 번째 주소검색 커스텀 텍스트 필드
    private var secondAddressInputTextField: some View {
        CustomTextField(text: $viewModel.secondAddressName,
                        placeholder: "주소를 검색해주세요.",
                        trailingHorizontalPadding: horizontalPadding + 35,
                        maxWidth: 275,
                        maxHeight: 45,
                        showSearchIcon: true,
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
    
    /// 두 번째 안내글 뷰
    private var secondeView: some View {
        VStack(alignment: .leading, spacing: 10) {
            CustomTitleView(titleText: "산책스팟의 위치를 알려주세요",
                      highlightText: ["위치"],
                      subtitleText: "산책로 중에 특정 위치의 주소를 입력해주세요 \n어디든 괜찮아요." ,
                      titleHeight: 36,
                      subtitleHeight: 50,
                      textAlignment: .leading,
                      frameAlignment: .topLeading
            )
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 8) {
                    secondAddressInputTextField
                    Button(action: {},
                           label: {
                        Icon.searchAddress.image
                            .resizable()
                            .frame(maxWidth: 48, maxHeight: 45)
                    })
                }
                secondDetailAddressInputTextField
            }
        }
        
    }
    
    //MARK: - ThirdView
    
    /// 세 번째 안내글 뷰
    private var thirdView: some View {
        CustomTitleView(titleText: "소개와 사진 등 산책스팟 \n정보를 입력해보세요",
                  highlightText: ["정보"],
                  subtitleText: "정보를 입력해야 방문객에게 장소가 보여요.",
                  titleHeight: 80,
                  textAlignment: .center,
                  frameAlignment: .center
        )
    }
    
    //MARK: - FourthView
    
    /// 네 번째 설명 텍스트 필드
    private var fourthWalkwayDescription: some View {
        CustomTextField(text: $viewModel.fourthWalkwayDescription,
                        placeholder: "예) 가족들이랑 걷기 좋은 오솔길",
                        fontSize: 15,
                        leadingHorizontalPadding: fourthHorizontalPadding,
                        trailingHorizontalPadding: fourthHorizontalPadding,
                        verticalPadding: fourthHorizontalPadding,
                        maxWidth: 314,
                        maxHeight: 102,
                        onSearch: {},
                        alignment: .topLeading,
                        axis: .vertical,
                        maxLength: 50
        )
    }
    
    /// 네 번째 안내글 뷰
    private var fourthView: some View {
        VStack(alignment: .leading, spacing: 10) {
            CustomTitleView(titleText: "산책스팟을 소개해주세요",
                      highlightText: ["소개"],
                      subtitleText: "나중에 언제든지 변경할 수 있으니, 걱정하지 마세요",
                      titleHeight: 36,
                      textAlignment: .leading,
                      frameAlignment: .topLeading
            )
            
            fourthWalkwayDescription
        }
    }
}

struct WalkwalyPageContent_Preview: PreviewProvider {
    static var previews: some View {
        WalkwayPageContent(viewModel: WalkwayViewModel())
    }
}
