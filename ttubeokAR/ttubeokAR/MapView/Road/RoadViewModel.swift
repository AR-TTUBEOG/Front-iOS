//
//  RoadViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 2/13/24.
//

import Foundation

class RoadViewModel: ObservableObject {
    var road: Road
    
    init(road: Road) {
        self.road = road
    }
}
