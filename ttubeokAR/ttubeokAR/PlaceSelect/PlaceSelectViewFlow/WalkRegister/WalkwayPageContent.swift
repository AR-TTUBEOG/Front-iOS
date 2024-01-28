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
    
    //MARK: - Body
    var body: some View {
        Text("1")
    }
    
    //MARK: - WalkwayPageContentView
    
    private var viewFlow: some View {
        switch viewModel.currentPageIndex {
        case 0:
            EmptyView()
        case 1:
            EmptyView()
        case 2:
            EmptyView()
        case 3:
            EmptyView()
        case 4:
            EmptyView()
        default:
            EmptyView()
        }
    }
    private var palceInputTextField: some View {
        Text
    }
    
    
    private var firstView: some View {
        VStack(alignment: .center, spacing: 32) {
            TitleView(titleText: "산책스팟의 이름을 알려주세요",
                      highlightText: "이름",
                      subtitleText: "지도에 등록되는 산책로의 이름이에요!",
                      spacing: 8)
        }
    }
}
