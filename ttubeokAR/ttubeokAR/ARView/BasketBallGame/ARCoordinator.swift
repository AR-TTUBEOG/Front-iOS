//
//  BasketBallAR.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/18/24.
//

import Foundation
import SceneKit
import ARKit
import UIKit
import RealityKit

class ARCoordinator: UIViewController, ARSCNViewDelegate, ObservableObject {
    
    var sceneView: ARSCNView!
    var currentNode: SCNNode?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sceneView = ARSCNView(frame: view.bounds)
        view.addSubview(sceneView)
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        sceneView.showsStatistics = false
        
        let scene = SCNScene()
        sceneView.scene = scene
    }
    //MARK: - 농구 게임
    func roundAction(node: SCNNode) {
        let upLeft = SCNAction.move(by: SCNVector3(1, 1, 0), duration: 2)
        let downRight = SCNAction.move(by: SCNVector3(1, -1, 0), duration: 2)
        let downLeft = SCNAction.move(by: SCNVector3(-1, -1, 0), duration: 2)
        let upRightt = SCNAction.move(by: SCNVector3(-1, 1, 0), duration: 2)
        
        let actionSequence = SCNAction.sequence([upLeft, downRight, downLeft, upRightt])
        
        node.runAction(SCNAction.repeat(actionSequence, count: 2))
    }
    
    func addHood() {
        guard let backboardScene = SCNScene(named: "art.scnassets/hoop.scn") else {
            return
        }
        
        guard let backboardNode = backboardScene.rootNode.childNode(withName: "backboard", recursively: false) else {
            return
        }
        
        backboardNode.position = SCNVector3(x: 0, y: 2, z: -7)
        
        let physicsShape = SCNPhysicsShape(node: backboardNode, options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron])
        let physicsBody = SCNPhysicsBody(type: .static, shape: physicsShape)
        backboardNode.physicsBody = physicsBody
        
        sceneView.scene.rootNode.addChildNode(backboardNode)
        
        currentNode = backboardNode
        
        backboardNode.scale = SCNVector3(2, 2, 2)
    }
    
    
    func registerGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
    }
    
    
    
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        guard let sceneView = gestureRecognizer.view as? ARSCNView else { return }
        
        guard let centerPoint = sceneView.pointOfView else { return }
        
        let cameraTransform = centerPoint.transform
        let cameraLocation = SCNVector3(x: cameraTransform.m41, y: cameraTransform.m42, z: cameraTransform.m43)
        let cameraOrientation = SCNVector3(-cameraTransform.m31, -cameraTransform.m32, -cameraTransform.m33)
        
        let cameraPosition = SCNVector3Make(cameraLocation.x + cameraOrientation.x, cameraLocation.y + cameraOrientation.y, cameraLocation.z + cameraOrientation.z)
        
        let ball = SCNSphere(radius: 0.23)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "ball.jpg")
        ball.materials = [material]
        
        let ballNode = SCNNode(geometry: ball)
        ballNode.position = cameraPosition
        
        let physicsShape = SCNPhysicsShape(node: ballNode, options: nil)
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
        ballNode.physicsBody = physicsBody
        
        let forceVector: Float = 12
        ballNode.physicsBody?.applyForce(SCNVector3(cameraOrientation.x * forceVector, cameraOrientation.y * forceVector, cameraOrientation.z * forceVector), asImpulse: true)
        
        sceneView.scene.rootNode.addChildNode(ballNode)
        
    }
    
    func startBasketballGame() {
        addHood()
        registerGestureRecognizer()
    }
    
    //MARK: - 박스 게임
    
    
    func dropBoxes() {
        for _ in 1...10 {
            guard let boxNode = loadBoxModel() else { continue }
            let randomPosition = getRandomPositionAboveCamera()
            boxNode.position = randomPosition
            sceneView.scene.rootNode.addChildNode(boxNode)

            
            let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            boxNode.physicsBody = physicsBody
        }
    }
    
    func loadBoxModel() -> SCNNode? {
        guard let boxScene = SCNScene(named: "art.scnassets/gift.usdz"),
              let boxNode = boxScene.rootNode.childNodes.first else {
            print("Failed to load the gift.usdz file")
            return nil
        }
        
        let scale: Float = 0.3
        boxNode.scale = SCNVector3(scale, scale, scale)
        
        return boxNode
    }
    
    
    
    func getRandomPositionAboveCamera() -> SCNVector3 {
        guard let currentFrame = sceneView.session.currentFrame else {
            return SCNVector3(0, 0, 0)
        }
        
        
        let cameraTransform = SCNMatrix4(currentFrame.camera.transform)
        let cameraPosition = SCNVector3Make(cameraTransform.m41, cameraTransform.m42, cameraTransform.m43)
      
        
        let maxDistance: Float = 15
            let minDistance: Float = 5

            // Generate random positions within a spherical area around the camera
            let randomX = Float(arc4random_uniform(UInt32(maxDistance * 200))) / 100.0 - maxDistance
            let randomY = Float(arc4random_uniform(UInt32(maxDistance * 200))) / 100.0 - maxDistance
            let randomZ = Float(arc4random_uniform(UInt32(maxDistance * 200))) / 100.0 - maxDistance

        
        var randomPosition = SCNVector3(
            x: cameraPosition.x + randomX,
            y: cameraPosition.y + randomY,
            z: cameraPosition.z + randomZ
        )
        
        let distance = sqrt(pow(randomPosition.x - cameraPosition.x, 2) + pow(randomPosition.y - cameraPosition.y, 2) + pow(randomPosition.z - cameraPosition.z, 2))
            if distance < minDistance {
                let scale = minDistance / distance
                randomPosition.x *= scale
                randomPosition.y *= scale
                randomPosition.z *= scale
            }

            return randomPosition
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            
            let hitTestResults = sceneView.hitTest(touchLocation, options: nil)
            if let hitTest = hitTestResults.first {
            
                hitTest.node.removeFromParentNode()
            }
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}
