//
//  ContentView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/2/24.
//

import SwiftUI
import RealityKit
import ARKit
import UIKit


struct ContentView : View {
    @StateObject var arCoordinator = ARCoordinator()
    
    let lastedTab: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            ARCoordinatorView(arCoordinator: arCoordinator).ignoresSafeArea(.all)
            topBtn
        }
    }
    
    private var topBtn: some View {
        HStack(spacing: 2) {
            Button(action: {
                changeRootViewToMainView(selectedTab: lastedTab)
            }) {
                Icon.closeView.image
                    .resizable()
                    .frame(width: 15, height: 20)
            }
            Spacer()
                .frame(maxWidth: 160)
            
            gameView
            
            Spacer()
        }
        .padding(.leading, 5)
    }
    
    
    private var gameView: some View {
        Button(action: {
            startRandomGmae()
        })
        {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 19)
                    .frame(maxWidth: 53, maxHeight: 40)
                
                Icon.gameStart.image
                    .resizable()
                    .frame(maxWidth: 29, maxHeight: 17)
            }
        }
    }
    
    private func startRandomGmae() {
        let selectedGame = Int.random(in: 1...3)
        switch selectedGame {
        case 1:
//            arCoordinator.startBasketballGame()
            print("1")
        case 2:
            arCoordinator.dropBoxes()
            print("1")
        case 3:
            print("!")
        default:
            break
        }
    }
    
    private func changeRootViewToMainView(selectedTab: Int) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeRootViewController(UIHostingController(rootView: MainViewControl(selectedTab: selectedTab).environmentObject(SharedTabInfo(currentTab: selectedTab))),animated: true)
    }
}

struct ARCoordinatorView: UIViewControllerRepresentable {
    var arCoordinator: ARCoordinator
    
    
    func makeUIViewController(context: Context) -> ARCoordinator {
        return arCoordinator
    }
    
    func updateUIViewController(_ uiViewController: ARCoordinator, context: Context) {}
    
    func updateUIView(_ uiViewController: ARCoordinator, context: Context) {}
    
    typealias UIViewControllerType = ARCoordinator
}
