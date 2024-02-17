//
//  BasketClassCoordinate.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/16/24.
//

import ARKit
import SwiftUI
import SceneKit

class ARCoordinator: NSObject, ARSCNViewDelegate {
    var arViewContainer: ARViewContainer
    var viewModel: ARGameViewModel

    init(_ container: ARViewContainer, viewModel: ARGameViewModel) {
        self.arViewContainer = container
        self.viewModel = viewModel
    }

    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        guard let ballNode = viewModel.ballNode, let hoopNode = viewModel.hoopNode else { return }

        // 공과 림의 충돌 감지
        if ballNode.presentation.position.distance(to: hoopNode.presentation.position) < 0.5 {
            // 공의 Y축 위치가 림의 Y축 위치보다 낮은지 확인
            if ballNode.presentation.position.y < hoopNode.presentation.position.y {
                // 골 성공
                DispatchQueue.main.async {
                    self.viewModel.ballScored()
                }
                // 공을 원래 위치로 리셋
                ballNode.position = SCNVector3(0, 0.5, -2) // 원래 위치로 변경
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 수평 평면 앵커를 확인
        if let planeAnchor = anchor as? ARPlaneAnchor {
            // ballNode가 nil이 아닌지 확인하고, 그렇다면 위치를 설정하고 루트 노드에 추가
            if let ballNode = viewModel.ballNode {
                // 평면의 중심에 공을 배치
                ballNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
                renderer.scene?.rootNode.addChildNode(ballNode)
            }
        }
    }



    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in view: ARSCNView) {
        let touch = touches.first!
        let location = touch.location(in: view)
        let hitResults = view.hitTest(location, options: nil)
        if let hitResult = hitResults.first, hitResult.node == viewModel.ballNode {
            viewModel.isBallSelected = true
        }
    }

    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in view: ARSCNView) {
        guard viewModel.isBallSelected else { return }
        let touch = touches.first!
        let location = touch.location(in: view)
        let previousLocation = touch.previousLocation(in: view)

        // 회전 값 계산
        let deltaX = Float(location.x - previousLocation.x)
        let deltaY = Float(location.y - previousLocation.y)

        // 공에 회전 적용
        viewModel.ballNode?.eulerAngles.x += deltaY * 0.01
        viewModel.ballNode?.eulerAngles.y += deltaX * 0.01
    }

    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in view: ARSCNView) {
        if viewModel.isBallSelected {
            // 공 던지기
            let force = SCNVector3(0, 0, -2) // 힘과 방향 조정
            viewModel.ballNode?.physicsBody?.applyForce(force, asImpulse: true)
        }
        viewModel.isBallSelected = false
    }
    
}

extension SCNVector3 {
    func distance(to vector: SCNVector3) -> CGFloat {
        let dx = self.x - vector.x
        let dy = self.y - vector.y
        let dz = self.z - vector.z
        return CGFloat(sqrt(dx*dx + dy*dy + dz*dz))
    }
}


