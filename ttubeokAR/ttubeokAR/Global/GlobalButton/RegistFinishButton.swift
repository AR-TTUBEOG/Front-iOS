//
//  FinishButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/3/24.
//

import SwiftUI

/// 확인버튼
//TODO: 뷰 모델 연결하여 API 호출
struct RegistFinishButton<ViewModel: FinishViewProtocol & ObservableObject>: View {
    
    //MARK: - Property
    @ObservedObject var viewModel: ViewModel
    @State var lastedSelectedTab: Int
    
    
    //MARK: - Body
    var body: some View {
        finishButton
    }
    
    //MARK: - FinishButton View
    private var finishButton: some View {
        Button(action: {
            viewModel.finishPlaceRegist()
            changeRootViewToMainView(selectedTab: lastedSelectedTab)
        }, label: {
            Text("확인")
                .font(.sandol(type: .medium, size: 20))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .frame(maxWidth: 335, maxHeight: 42)
                .background((RoundedRectangle(cornerRadius: 19).fill(Color.primary03)))
        })
    }
    
    /// 원래의 루트뷰로 돌아가는 함수
    /// - Parameter selectedTab: 기존의 선택된 루트뷰의 선택된 탭
    private func changeRootViewToMainView(selectedTab: Int) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeRootViewController(UIHostingController(rootView: MainViewControl(selectedTab: selectedTab).environmentObject(SharedTabInfo())),animated: true)
    }
    
}
