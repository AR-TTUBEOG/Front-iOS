//
//  RouteViewModel.swift
//  MapTracking
//
//  Created by Subeen on 2/17/24.
//

import Foundation
import MapKit

class RouteViewModel: ObservableObject {
    @Published var history: [CLLocationCoordinate2D]
    
    init(history: [CLLocationCoordinate2D] = []) {
        self.history = history
    }
}
