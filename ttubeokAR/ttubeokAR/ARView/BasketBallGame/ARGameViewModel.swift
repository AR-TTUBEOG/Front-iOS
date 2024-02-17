//
//  ARGameViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/16/24.
//

import Foundation
import SceneKit
import ARKit

class ARGameViewModel: ObservableObject {
    @Published var score = 0
    @Published var timeLeft = 30
    
    var timer: Timer?
    var ballNode: SCNNode?
    var hoopNode: SCNNode?
    var isBallSelected = false
    
    init() {
        loadModel()
    }
    
    func startGame() {
        score = 0
        timeLeft = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.timeLeft -= 1
            if self?.timeLeft == 0 {
                self?.timer?.invalidate()
                // 게임 종료 로직
            }
        }
    }
    
    func loadModel() {
        let scene = SCNScene(named: "basketBall.usdz")
        self.ballNode = scene?.rootNode.childNode(withName: "basketBall", recursively: true)
        
                guard let hoopURL = Bundle.main.url(forResource: "basketballstand", withExtension: "usdz"),
                      let hoopScene = try? SCNScene(url: hoopURL, options: nil) else { return }
                hoopNode = hoopScene.rootNode.childNodes.first
        
        
    }
    
        func setupARConfiguration(for arView: ARSCNView) {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = .horizontal
            arView.session.run(configuration)
        }
        
        
        
        func setupPhysicsForBall(_ node: SCNNode?) {
            if let node = node {
                let physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: node, options: nil))
                physicsBody.mass = 0.6
                physicsBody.restitution = 0.7
                node.physicsBody = physicsBody
            }
        }
        
        func resetBallPosition() {
            ballNode?.position = SCNVector3(0, 0.0, 0) // 공의 초기 위치
        }
        
        func ballScored() {
            score += 1
        }
    }
