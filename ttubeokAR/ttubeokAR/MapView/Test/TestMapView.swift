//
//  TestMapView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/18/24.
//

import SwiftUI
import NMapsMap
import NMapsGeometry

struct TestMapView: View {
    
    // Coordinator 클래스
        @StateObject var coordinator: Coordinator = Coordinator.shared
    
    var body: some View {
        ZStack{
            NaverMap()
                .ignoresSafeArea(.all, edges: .top)
            
        }
        .onAppear {
                    Coordinator.shared.checkIfLocationServiceIsEnabled()
                }
    }
}


struct NaverMap: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
    
}

#Preview {
    TestMapView()
}
