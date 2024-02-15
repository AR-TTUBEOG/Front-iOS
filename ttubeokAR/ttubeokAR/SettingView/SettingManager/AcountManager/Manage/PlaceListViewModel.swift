//
//  ManagePlaceViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 1/21/24.
//

import Foundation

class PlaceListViewModel: ObservableObject {
    @Published var type: PlaceType
    @Published var places: [Place]
    
    init(
        type: PlaceType = .restaurant,
        places: [Place] = [
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)),
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)),
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)),
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)),
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)),
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)),
            .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3))
        ]
    ) {
        self.type = type
        self.places = places
        
    }
    
    enum PlaceType: String {
        case route
        case restaurant
    }
}

extension PlaceListViewModel {
    func updatePlace(_ place: Place) {
        if let index = places.firstIndex(where: { $0.information.hashValue == place.information.hashValue}) {
            places[index] = place
        }
    }
    
    func removePlace(_ place: Place) {
        if let index = places.firstIndex(where: { $0.information.hashValue == place.information.hashValue }) {
            places.remove(at: index)
        }
    }
}
