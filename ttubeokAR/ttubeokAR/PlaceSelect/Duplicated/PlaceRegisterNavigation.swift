//
//  CustomSlider.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//


import SwiftUI
struct PlaceRegisterNavigation: View {
    //MARK: - Property
    var currentPage: Int
    let totalPages: Int
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            customNavigation
        }
    }
    //MARK: - PlaceRegisterSlider
    /// 상단 커스텀 네비게이션 구현
    private var customNavigation: some View {
        VStack(alignment: .center, spacing: 8) {
            NavigationBar(title: "Step \(currentPage) / \(totalPages)",
                          fontSize: 13,
                          fontType: .light
            )
            
            ProgressView(value: Double(currentPage) / Double(totalPages))
                .progressViewStyle(LinearProgressViewStyle())
        }
    }
}

struct PlaceRegisterNavigation_Preview: PreviewProvider {
    static var previews: some View {
        PlaceRegisterNavigation(currentPage: 4, totalPages: 5)
    }
}
