//
//  ContentView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/2/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    @StateObject var arViewModel = ARViModel()
    
    var body: some View {
        ARViewContainer(arViewModel: arViewModel)
            .ignoresSafeArea(.all)
            .onTapGesture {
                self.arViewModel.handleTap()
            }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var arViewModel: ARViModel

    
    func makeUIView(context: Context) -> ARSCNView {
       let view = ARSCNView()
        view.session.run(ARWorldTrackingConfiguration())
        return view
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator() 
    }
}
#Preview {
    ContentView()
}
