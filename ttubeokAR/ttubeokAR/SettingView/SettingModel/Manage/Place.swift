//
//  Place.swift
//  ttubeokAR
//
//  Created by Subeen on 1/21/24.
//

import Foundation

// MARK: - Route
struct Place: Hashable {
    
    let check: Bool
    let information: PlaceInformation
//    let id: UUID
}

// MARK: - Information
struct PlaceInformation: Hashable {
    let id, dongAreaID: Int
    let detailAddress, name, info: String
    let latitude, longtitude: Double
    let image: [String]
    let stars: Double

    enum CodingKeys: String, CodingKey {
        case id
        case dongAreaID = "dongAreaId"
        case detailAddress, name, info, latitude, longtitude, image, stars
    }
}
