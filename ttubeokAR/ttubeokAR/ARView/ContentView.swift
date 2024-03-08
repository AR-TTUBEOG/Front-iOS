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
    @State var isOnWheel = false
    
    let lastedTab: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            ARCoordinatorView(arCoordinator: arCoordinator).ignoresSafeArea(.all)
            topBtn
            
            if isOnWheel {
                VStack {
                    Spacer()
                        .frame(maxHeight: 200)
                    gameWheel
                }
            }
        }
    }
    
    private var topBtn: some View {
        HStack(spacing: 2) {
            Button(action: {
                changeRootViewToMainView(selectedTab: lastedTab)
            }) {
                Icon.closeView.image
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 10)
            }
            Spacer()
                .frame(maxWidth: 160)
            
            gameView
            
            Spacer()
        }
        .padding(.leading, 1)
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
        let selectedGame = Int.random(in: 1...2)
        switch selectedGame {
        case 1:
            self.isOnWheel = false
            arCoordinator.startBasketballGame()
        case 2:
            self.isOnWheel.toggle()
        default:
            break
        }
    }
    
    private var gameWheel: some View {
        ZStack{
            WheelGameShapeView(viewModel: WheelGameViewModel())
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
