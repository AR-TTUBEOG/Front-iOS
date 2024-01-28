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
    private let cornerSize: CGFloat = 19
    
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
//        case 1:
//            EmptyView()
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
    
    private var placeInputTextField: some View {
        CustomTextField(text: $viewModel.inputText, placeholder: "예) 낙산공원", cornerSize: 19, horizaontalPadding: 15, verticalPadding: 5)
        
    }
    
    
    private var firstView: some View {
        VStack(alignment: .center, spacing: 32) {
            TitleView(titleText: "산책스팟의 이름을 알려주세요",
                      highlightText: "이름",
                      subtitleText: "지도에 등록되는 산책로의 이름이에요!",
                      subtitleSize: 15,
                      titleWidth: 350,
                      titleHeight: 36,
                      subtitleWidth: 285,
                      subtitleHeight: 30,
                      spacing: 8)
            placeInputTextField
        }
    }
}

struct WalkwalyPageContent_Preview: PreviewProvider {
    static var previews: some View {
        WalkwayPageContent(viewModel: WalkwayViewModel())
    }
}
