//
//  SwiftUIView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/10/24.
//

import SwiftUI

struct MapView: View {
    
    // Coordinator 클래스
        @StateObject var coordinator: Coordinator = Coordinator.shared
    
    var body: some View {
        ZStack{
//            NaverMap()
//                .ignoresSafeArea(.all, edges: .top)
            
        }
        .onAppear {
                    Coordinator.shared.checkIfLocationServiceIsEnabled()
                }
    }
}



#Preview {
    MapView()
}
