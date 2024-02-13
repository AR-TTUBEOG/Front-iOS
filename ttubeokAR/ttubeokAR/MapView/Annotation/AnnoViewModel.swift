//
//  AnnoViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 2/6/24.
//

import Foundation
import SwiftUI

class AnnoViewModel: ObservableObject {
    @Published var annoType: AnnoType
    @Published var annos: [Anno]
    
    init(
        annoType: AnnoType = .cafe,
        annos: [Anno] = [
//            .init(latitude: 37.256406, longitude: 127.064556, type: .cafe, image: "mapPlaceExample", isSelected: false),37.547889, 126.915158  37.547623, 126.916014  37.549873, 126.915642
            .init(storeId: 1, dongareaId: 1, name: "카페", info: "분위기 좋은 카페", latitude: 37.547889, longitude: 126.915158, image: "exampleMarket", type: "cafe"),
            .init(storeId: 2, dongareaId: 1, name: "중학교", info: "분위기 좋은 중학교", latitude: 37.547623, longitude: 126.916014, image: "exampleMarket", type: "route"),
            .init(storeId: 3, dongareaId: 1, name: "피자", info: "분위기 좋은 피자", latitude: 37.549873, longitude: 126.915642, image: "exampleMarket", type: "restaurant"),

            ]
    ) {
        self.annoType = annoType
        self.annos = annos
    }
}

enum AnnoType {
    case cafe
    case restaurant
    case route
}

extension AnnoViewModel {
    
}
