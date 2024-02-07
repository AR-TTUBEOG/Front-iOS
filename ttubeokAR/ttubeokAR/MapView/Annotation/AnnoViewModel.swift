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
            .init(latitude: 37.256406, longitude: 127.064556, type: .cafe, image: Image(.mapPlaceExample), isSelected: false),
            .init(latitude: 37.255910, longitude: 127.064008, type: .cafe, image: Image(.mapPlaceExample), isSelected: false),
            .init(latitude: 37.253476, longitude: 127.066337, type: .cafe, image: Image(.mapPlaceExample), isSelected: false)
            ]
    ) {
        self.annoType = annoType
        self.annos = annos
    }
}

extension AnnoViewModel {
    
}
