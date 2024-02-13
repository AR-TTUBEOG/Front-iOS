//
//  Road.swift
//  ttubeokAR
//
//  Created by Subeen on 2/13/24.
//

import Foundation

struct Road : Hashable {
    var spotId: Int
    var name: String
    var roadFile: [[Double]]
    var time: String
}

enum RoadType {
    case cafe
    case restaurant
    case route
}
