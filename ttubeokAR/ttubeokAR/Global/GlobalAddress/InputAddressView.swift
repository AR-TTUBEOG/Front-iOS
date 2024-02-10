//
//  InputAddressGroup.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/9/24.
//

import SwiftUI
import Moya

struct InputAddressView<ViewModel: InputAddressProtocol & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    private let horizontalPadding: CGFloat = 15
    let provider = MoyaProvider<NaverReverseGeocodingAPI>()
    
    
    var body: some View {
        groupAddressInputs
    }
    
    /// 주소검색 커스텀 텍스트 필드
    private var addressInputTextField: some View {
        CustomTextField(text: $viewModel.address,
                        placeholder: "주소를 검색해주세요.",
                        fontSize: 20,
                        trailingHorizontalPadding: horizontalPadding,
                        maxWidth: 295,
                        maxHeight: 45,
                        onSearch: {}
        )
        .disabled(true)
    }
    
    /// 상세 주소 입력
    private var detailAddressInputTextField: some View {
        CustomTextField(text: $viewModel.detailAddress,
                        placeholder: "상세주소를 입력해주세요.",
                        trailingHorizontalPadding: horizontalPadding,
                        maxWidth: 355,
                        maxHeight: 45,
                        onSearch: {}
        )
    }
    
    //TODO: - 버튼 처리 로직 필요
    private var groupAddressInputs: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 8) {
                addressInputTextField
                Button(action: {
                    viewModel.searchAddress()
                },
                       label: {
                    Icon.searchAddress.image
                        .resizable()
                        .frame(maxWidth: 48, maxHeight: 45)
                })
            }
            detailAddressInputTextField
        }
    }
}