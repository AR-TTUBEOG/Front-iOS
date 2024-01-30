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
    @ObservedObject var viewModel = WalkwayViewModel()
    @State private var walkWayName = ""
    @State private var selectedImages: [UIImage] = []
    
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
        case 4:
            fifthView
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
        ZStack(alignment: .bottomTrailing) {
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
                            maxLength: 60
            )
            
            Text("\(viewModel.fourthWalkwayDescription.count) / 50")
                .frame(maxWidth: 48, maxHeight: 30, alignment: .center)
                .font(.sandol(type: .regular, size: 11))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textPink)
                .padding([.trailing, .bottom], 5)
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
        .frame(maxWidth: 304, maxHeight: 27, alignment: .leading)
    }
    
    /// 네 번째 예시 사진
    private var fourthExampleImage: some View {
        Icon.examplePlace.image
            .resizable()
            .frame(maxWidth: 326, maxHeight: 240)
    }
    
    /// 네 번째 안내글 뷰
    private var fourthView: some View {
        VStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 20) {
                CustomTitleView(titleText: "산책스팟을 소개해주세요",
                                highlightText: ["소개"],
                                subtitleText: "나중에 언제든지 변경할 수 있으니, 걱정하지 마세요",
                                titleHeight: 36,
                                textAlignment: .leading,
                                frameAlignment: .topLeading
                )
                fourthWalkwayDescription
                
                VStack(alignment: .leading, spacing: 24) {
                    fourthInformationNotice
                    fourthExampleImage
                }
            }
        }
        .frame(maxWidth: 330)
    }
    
    //MARK: - fifthView
    
    /// 이미지 추가 버튼
    private var fifthAddImageButton: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 19)
                .foregroundStyle(Color.clear)
                .frame(maxWidth: 80, maxHeight: 80)
                .background(Color.textPink)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .inset(by: 0.75)
                        .stroke(Color.primary04, lineWidth: 1.5)
                )
            VStack(alignment: .center, spacing: 8)
            {
                Icon.camera.image
                    .resizable()
                    .frame(maxWidth: 32, maxHeight: 28)
                Text("\(viewModel.selectedImageCount) / 10")
                    .font(.sandol(type: .medium, size: 11))
                    .foregroundStyle(Color.primary03)
                    .frame(maxWidth: 28, maxHeight: 18, alignment: .center)
            }
        }
        .frame(maxWidth: 80, maxHeight: 80)
        .clipShape(.rect(cornerRadius: 19))
    }
    
    /// 선택한 사진들 보기
    private var fifthShowImages: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                ForEach(viewModel.walwayModel.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxWidth: 80, maxHeight: 80)
                        .clipShape(.rect(cornerRadius: 19))
                }
            }
        }
    }
    
    /// 이미지 추가 버튼 및 추가한 이미지 뷰
    private var fifthChoiceImageView: some View {
        HStack(spacing: 13) {
            Button(action: {
                viewModel.showImagePicker()
            }) {
                fifthAddImageButton
            }
            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                PlaceRegistImagePicker(viewModel: viewModel)
            }
            fifthShowImages
        }
    }
    
    /// 다섯 번째 안내문 뷰
    private var fifthInformationNotice: some View {
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
    
    /// 다섯 번째 예시 사진
    private var fifththExampleImage: some View {
        Icon.examplePlace2.image
            .resizable()
            .frame(maxWidth: 326, maxHeight: 260)
    }
    
    /// 다섯 번째 뷰
    private var fifthView: some View {
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading) {
                CustomTitleView(titleText: "배경사진을 등록해주세요",
                                highlightText: ["사진, 등록"],
                                subtitleText: "방문객은 배경 사진을 보고 산책로를 파악해요. \n사진은 이후 변경할 수 있지만 한 장은 필수 등록이에요!",
                                titleHeight: 36,
                                subtitleHeight: 60,
                                textAlignment: .leading,
                                frameAlignment: .topLeading)
                fifthChoiceImageView
            }
            VStack(alignment: .leading, spacing: 14) {
                fifthInformationNotice
                fifththExampleImage
            }
        }
        .frame(maxWidth: 330)
    }
}

struct WalkwalyPageContent_Preview: PreviewProvider {
    static var previews: some View {
        WalkwayPageContent(viewModel: WalkwayViewModel())
    }
}
