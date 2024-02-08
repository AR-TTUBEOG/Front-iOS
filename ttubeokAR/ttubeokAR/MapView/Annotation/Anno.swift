//
//  Anno.swift
//  ttubeokAR
//
//  Created by Subeen on 2/6/24.
//

import Foundation
import SwiftUI

struct Anno : Hashable {
    var id: UUID = UUID()
    var latitude: Double
    var longitude: Double
//    var location: CLLocationCoordinate2D
    var type: AnnoType
    var image: String
    var isSelected: Bool
}



enum AnnoType {
    case cafe
    case restaurant
    case route
}
