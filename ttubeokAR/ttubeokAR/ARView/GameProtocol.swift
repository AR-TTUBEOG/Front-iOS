//
//  GameProtocol.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/18/24.
//

import Foundation
import ARKit
import RealityKit

protocol Game {
    mutating func setupGame(arView: ARView)
    mutating func startGame(arView: ARView)
    mutating func stopGame()
}
