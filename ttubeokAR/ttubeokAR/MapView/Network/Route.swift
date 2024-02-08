//
//  Route.swift
//  ttubeokAR
//
//  Created by Subeen on 1/24/24.
//

import Foundation

// MARK: - Welcome
struct RouteResponse: Codable {
    let code: String
    let routes: [Route]
//    let waypoints: [Waypoint]
}

// MARK: - Route
struct Route: Codable {
    let geometry: Geometry
    let legs: [Leg]
    let weightName: String
    let weight, duration, distance: Double

    enum CodingKeys: String, CodingKey {
        case geometry, legs
        case weightName = "weight_name"
        case weight, duration, distance
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let coordinates: [[Double]]
    let type: String
}

// MARK: - Leg
struct Leg: Codable {
    let steps: [Step]
    let summary: String
    let weight, duration, distance: Double
}

// MARK: - Step
struct Step: Codable {
    let geometry: Geometry
//    let maneuver: Maneuver
//    let mode, drivingSide, name: String
//    let intersections: [Intersection]
    let weight, duration, distance: Double

    enum CodingKeys: String, CodingKey {
        case geometry
//        case drivingSide = "driving_side"
        case weight, duration, distance
    }
}

