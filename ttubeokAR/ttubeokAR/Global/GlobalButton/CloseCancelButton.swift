//
//  CancelButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import SwiftUI

/// 뚜닷으로 연결된 뷰의 종료 버튼
struct CloseCancelButton: View {
    
    //MARK: - Property
    @State var lastedSelectedTab: Int
    
    //MARK: - Body
    var body: some View {
            closeButton
    }
    //MARK: - CloseCancelButtonView
    /// 뷰 종료 버튼
    private var closeButton: some View {
            Button(action: {
                changeRootViewToMainView(selectedTab: lastedSelectedTab)
            }){
                Icon.closeView.image
                    .resizable()
                    .frame(maxWidth: 11, maxHeight: 18)
            }
    }
    
    /// 원래의 루트뷰로 돌아가는 함수
    /// - Parameter selectedTab: 기존의 선택된 루트뷰의 선택된 탭
    private func changeRootViewToMainView(selectedTab: Int) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeRootViewController(UIHostingController(rootView: MainViewControl(selectedTab: selectedTab).environmentObject(SharedTabInfo(currentTab: selectedTab))),animated: true)
    }
}
