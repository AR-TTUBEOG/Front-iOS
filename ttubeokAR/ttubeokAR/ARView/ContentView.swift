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
    
    @ObservedObject var viewModel = ARGameViewModel()
    
    
    var body: some View {
        
        VStack {
            Text("Time Left: \(viewModel.timeLeft)")
            Text("Score: \(viewModel.score)")
            ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            viewModel.startGame()
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    var viewModel: ARGameViewModel
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator
        if let ballNode = viewModel.ballNode, let hoopNode = viewModel.hoopNode {
            arView.scene.rootNode.addChildNode(ballNode)
            arView.scene.rootNode.addChildNode(hoopNode)
        }
        arView.session.run(ARWorldTrackingConfiguration())
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> ARCoordinator {
        ARCoordinator(self, viewModel: viewModel)
    }
}
#Preview {
    ContentView()
}
