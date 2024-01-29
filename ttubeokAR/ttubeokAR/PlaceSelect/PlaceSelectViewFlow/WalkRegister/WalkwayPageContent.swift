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
    
    //MARK: - TitleShame
    private let cornerSize: CGFloat = 19
    private let subtitleSize: CGFloat = 15
    private let titleWidth: CGFloat = 350
    private let subtitleWidth: CGFloat = 350
    private let subtitleHeight: CGFloat = 50
    private let spacing: CGFloat = 15
    
    //MARK: - TextFieldShame
    private let horizaontalPadding: CGFloat = 15
    private let verticalPadding: CGFloat = 5
    
    
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
            //        case 2:
            //            EmptyView()
            //        case 3:
            //            EmptyView()
            //        case 4:
            //            EmptyView()
        default:
            EmptyView()
        }
    }
    
    //MARK: - WalkwayFirstView
    
    /// 장소이름 커스텀 텍스트 필드
    private var firstPlaceInputTextField: some View {
        CustomTextField(text: $viewModel.firstPlaceName, placeholder: "예) 낙산공원", cornerSize: cornerSize, horizaontalPadding: horizaontalPadding, verticalPadding: verticalPadding, maxWidth: 345, maxHeight: 45, showSearchIcon: false, onSearch: {})
    }
    
    
    /// 장소 등록 첫 번째 페이지 요소
    private var firstView: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleView(titleText: "산책스팟의 이름을 알려주세요",
                      highlightText: "이름",
                      subtitleText: "지도에 등록되는 산책로의 이름이에요!",
                      subtitleSize: subtitleSize,
                      titleWidth: titleWidth,
                      titleHeight: 36,
                      subtitleWidth: subtitleWidth,
                      subtitleHeight: subtitleHeight,
                      spacing: spacing,
                      textAlignment: .leading,
                      frameAlignment: .topLeading
            )
            firstPlaceInputTextField
        }
    }
    
    //MARK: - WalkwaySecondView
    
    /// 주소검색 커스텀 텍스트 필드
    private var secondAddressInputTextField: some View {
        CustomTextField(text: $viewModel.secondAddressName, placeholder: "주소를 검색해주세요.", cornerSize: cornerSize, horizaontalPadding: horizaontalPadding, verticalPadding: verticalPadding, maxWidth: 275, maxHeight: 45, showSearchIcon: true, onSearch: {})
    }
    
    private var secondDetailAddressInputTextField: some View {
        CustomTextField(text: $viewModel.secondDetailAddress, placeholder: "상세주소를 입력해주세요.", cornerSize: cornerSize, horizaontalPadding: horizaontalPadding, verticalPadding: verticalPadding, maxWidth: 332, maxHeight: 45, showSearchIcon: false, onSearch: {})
    }
    
    private var secondeView: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleView(titleText: "산책스팟의 위치를 알려주세요",
                      highlightText: "위치",
                      subtitleText: "산책로 중에 특정 위치의 주소를 입력해주세요 \n어디든 괜찮아요." ,
                      subtitleSize: subtitleSize,
                      titleWidth: titleWidth,
                      titleHeight: 36,
                      subtitleWidth: subtitleWidth,
                      subtitleHeight: subtitleHeight,
                      spacing: spacing,
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
}

struct WalkwalyPageContent_Preview: PreviewProvider {
    static var previews: some View {
        WalkwayPageContent(viewModel: WalkwayViewModel())
    }
}
