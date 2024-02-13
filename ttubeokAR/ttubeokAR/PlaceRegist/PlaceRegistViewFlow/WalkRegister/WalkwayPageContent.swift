//
//  WalkwayPageContent.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import SwiftUI
import PopupView

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
        viewFlow
    }
    
    
    //MARK: - WalkwayPageContentView
    
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
                fourthView
            }
        case 4:
            fifthView
        case 5:
            Text("완료}")
        default:
            EmptyView()
        }
    }
    
    //MARK: - WalkwayFirstView
    
    /// 첫 번째장소이름 커스텀 텍스트 필드
    private var firstPlaceInputTextField: some View {
        CustomTextField(text: $viewModel.firstPlaceName,
                        placeholder: "예) 낙산공원",
                        maxWidth: 320,
                        maxHeight: 38,
                        onSearch: {})
    }
    
    
    /// 첫 번째 안내글 뷰
    private var firstView: some View {
        VStack(alignment: .leading, spacing: 35) {
            CustomTitleView(titleText: "산책스팟의 이름을 알려주세요",
                            highlightText: ["이름"],
                            subtitleText: "지도에 등록되는 산책로의 이름이에요!",
                            titleHeight: 36,
                            textAlignment: .leading,
                            frameAlignment: .topLeading
            )
            firstPlaceInputTextField
        }
        .frame(width: 360, alignment: .center)
    }
    
    //MARK: - WalkwaySecondView
    
    /// 두 번째 안내글 뷰
    private var secondView: some View {
        VStack(alignment: .leading, spacing: 15) {
            CustomTitleView(titleText: "산책스팟의 위치를 알려주세요",
                            highlightText: ["위치"],
                            subtitleText: "산책로 중에 특정 위치의 주소를 입력해주세요 \n어디든 괜찮아요." ,
                            titleHeight: 36,
                            subtitleHeight: 50,
                            textAlignment: .leading,
                            frameAlignment: .topLeading
            )
            
            InputAddressView(viewModel: viewModel)
        }
        .frame(width: 360, alignment: .center)
        
    }
    
    //MARK: - ThirdView
    
    /// 세 번째 안내글 뷰
    private var thirdView: some View {
        CustomTitleView(titleText: "소개와 사진 등 산책스팟 \n정보를 입력해보세요",
                        highlightText: ["정보"],
                        subtitleText: "정보를 입력해야 방문객에게 장소가 보여요.",
                        titleHeight: 80,
                        spacing: 1,
                        textAlignment: .center,
                        frameAlignment: .center
        )
    }
    
    //MARK: - FourthView
    
    /// 네 번째 설명 텍스트 필드
    private var fourthWalkwayDescription: some View {
        ZStack(alignment: .bottomTrailing) {
            CustomTextField(text: $viewModel.fourthWalkwayDescription,
                            placeholder: "예) 가족들이랑 걷기 좋은 오솔길",
                            fontSize: 15,
                            leadingHorizontalPadding: fourthHorizontalPadding,
                            trailingHorizontalPadding: fourthHorizontalPadding,
                            verticalPadding: fourthVerticalPadding,
                            maxWidth: 300,
                            maxHeight: 90,
                            onSearch: {},
                            alignment: .topLeading,
                            axis: .vertical,
                            maxLength: 50
            )
            
            Text("\(viewModel.fourthWalkwayDescription.count) / 50")
                .frame(width: 48, height: 30, alignment: .center)
                .font(.sandol(type: .regular, size: 11))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textPink)
        }
    }
    
    /// 네 번째 안내문 뷰
    private var fourthInformationNotice: some View {
        HStack(spacing: 9) {
            Icon.lightOn.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 27, maxHeight: 27)
            Text("입력한 정보는 이렇게 화면에 나와요.")
                .font(.sandol(type: .medium, size: 12))
                .foregroundStyle(.textPink)
                .frame(maxWidth: 268, maxHeight: 16, alignment: .leading)
            
        }
        .frame(maxWidth: 324, maxHeight: 27, alignment: .leading)
    }
    
    /// 네 번째 예시 사진
    private var fourthExampleImage: some View {
        Icon.examplePlace.image
            .resizable()
            .frame(width: 340, height: 280)
    }
    
    /// 네 번째 뷰
    private var fourthView: some View {
        VStack(alignment: .leading, spacing: 20) {
            
                CustomTitleView(titleText: "산책스팟을 소개해주세요",
                                highlightText: ["소개"],
                                subtitleText: "나중에 언제든지 변경할 수 있으니, 걱정하지 마세요",
                                titleHeight: 36,
                                textAlignment: .leading,
                                frameAlignment: .topLeading
                )
            
            VStack(alignment: .leading, spacing: 30) {
                fourthWalkwayDescription
                
                
                VStack(alignment: .leading, spacing: 24) {
                    fourthInformationNotice
                    fourthExampleImage
                }
            }
        }
        .frame(width: 360, alignment: .center)
    }
    
    //MARK: - fifthView
    
    /// 다섯 번째 안내문 뷰
    private var fifthInformationNotice: some View {
        HStack(spacing: 9) {
            Icon.lightOn.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 27, height: 27)
            Text("등록된 사진은 이렇게 보여요.")
                .font(.sandol(type: .medium, size: 12))
                .foregroundStyle(.textPink)
                .frame(width: 268, height: 16, alignment: .leading)
            
        }
        .frame(width: 304, height: 27)
    }
    
    /// 다섯 번째 예시 사진
    private var fifththExampleImage: some View {
        Icon.examplePlace2.image
            .resizable()
            .frame(width: 340, height: 280)
    }
    
    /// 다섯 번째 뷰
    private var fifthView: some View {
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading, spacing: 2) {
                CustomTitleView(titleText: "배경사진을 등록해주세요",
                                highlightText: ["사진", "등록"],
                                subtitleText: "방문객은 배경 사진을 보고 산책로를 파악해요. \n사진은 이후 변경할 수 있지만 한 장은 필수 등록이에요!",
                                titleWidth: 330,
                                titleHeight: 36,
                                subtitleWidth: 330,
                                subtitleHeight: 60,
                                textAlignment: .leading,
                                frameAlignment: .topLeading)
                
                ImageSelectionButton(viewModel: viewModel)
            }
            VStack(alignment: .leading, spacing: 14) {
                fifthInformationNotice
                fifththExampleImage
            }
        }
        .frame(maxWidth: 360)
        .padding(.leading, -10)
    }
}

struct WalkwalyPageContent_Preview: PreviewProvider {
    static var previews: some View {
        WalkwayPageContent(viewModel: WalkwayViewModel())
            .previewLayout(.sizeThatFits)
    }
}
