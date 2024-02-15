//
//  PlaceViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 2/1/24.
//

import Foundation

class PlaceViewModel: ObservableObject {
    @Published var place: Place
    
    init(place: Place) {
        self.place = place
    }
}
