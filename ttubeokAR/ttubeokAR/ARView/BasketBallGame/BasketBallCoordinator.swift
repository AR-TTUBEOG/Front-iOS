//
//  Coordinator.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/18/24.
//

import Foundation
import SceneKit
import ARKit

class ARViModel: ObservableObject {
    private var sceneView: ARSCNView!
    
    func addHoop() {
        guard let backboardScene = SCNScene(named: "basketballstand.usdz"),
              let backboardNode = backboardScene.rootNode.childNode(withName: "backboard", recursively: false) else {
            return
        }
        
        sceneView.scene.rootNode.addChildNode(backboardNode)
    }
    
    func handleTap() {
           guard let ballScene = SCNScene(named: "basketBall.usdz"),
                 let ballNode = ballScene.rootNode.childNode(withName: "ball", recursively: true) else {
               return
           }

           // 카메라 위치 및 방향 계산
           let cameraTransform = sceneView.session.currentFrame?.camera.transform
           let cameraPosition = SCNVector3(cameraTransform!.columns.3.x, cameraTransform!.columns.3.y, cameraTransform!.columns.3.z)
           ballNode.position = cameraPosition

           // 농구공에 물리적 속성 추가
           let physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: ballNode, options: nil))
           ballNode.physicsBody = physicsBody

           // 탭 제스처로 공 날리기
           let forceVector: Float = 6
           ballNode.physicsBody?.applyForce(SCNVector3(0, forceVector, forceVector), asImpulse: true)

           // 공을 씬에 추가
           sceneView.scene.rootNode.addChildNode(ballNode)
       }
}
