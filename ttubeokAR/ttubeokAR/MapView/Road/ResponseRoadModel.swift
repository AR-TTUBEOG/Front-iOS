//
//  Road.swift
//  ttubeokAR
//
//  Created by Subeen on 2/13/24.
//

import Foundation

// MARK: - RoadElement

struct RequestRoadModel: Codable {
    let roadType: String
    let spotID, storeID, memberID: Int
    let name: String
    let roadCoordinateDoubleList: [[Double]]
}

struct ResponseRoadModel: Codable{
    var check: Bool
    var information: [RoadModel]
}

struct RoadModel: Codable, Hashable {
    let id: Int
    let roadType: String
    let spotID, storeID, memberID: Int
    let memberName, name: String    // 멤버 이름, 길 이름 
    let roadCoordinateDoubleList: [[Double]]
}
