//
//  PlaceRegisterFinishView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/3/24.
//

import SwiftUI

struct PlaceRegisterFinishView<ViewModel: FinishViewProtocol & ObservableObject> : View {
    
    @ObservedObject var viewModel: ViewModel
    let lastedSelectedTab: Int
    
    var body: some View {
        allView
            .navigationBarBackButtonHidden(true)
    }
    
    private var allView: some View {
        VStack {
            finishTitle
                .padding(.top, 100)
            
            Spacer()
            
            FinishButton(viewModel: viewModel, lastedSelectedTab: lastedSelectedTab)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.background.ignoresSafeArea(.all))
    }
    
    private var finishTitle: some View {
        VStack(alignment: .center, spacing: 35) {
            Icon.placeFinish.image
                .resizable()
                .frame(maxWidth: 247, maxHeight: 90)
            CustomTitleView(titleText: viewModel.titleText,
                            highlightText: [viewModel.highlightText],
                            subtitleText: "",
                            titleWidth: 300,
                            titleHeight: 100,
                            spacing: 40,
                            textAlignment: .center,
                            frameAlignment: .center)
            
            .frame(maxWidth: 330, maxHeight: 200)
        }
        .frame(maxWidth: 278, maxHeight: 300)
    }
}

struct PlaceRegisterFinishView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRegisterFinishView(viewModel: WalkwayViewModel(), lastedSelectedTab: 1)
    }
}
