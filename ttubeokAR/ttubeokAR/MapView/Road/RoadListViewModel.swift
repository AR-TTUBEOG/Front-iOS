//
//  RoadListViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 2/13/24.
//

import Foundation

class RoadListViewModel: ObservableObject {
//    "spotId": 1,
//            "name": "정상제의 산책로",
//            "roadFile": "https://~",
//            "time": "13분 45초"
    
    @Published var roadList: [Road]
    
    init(
        roadList: [Road] = [
            .init(spotId: 1, name: "스티브의길", roadFile: [[126.915277,37.547834],[126.915321,37.54799],[126.914657,37.548117],[126.914829,37.548661],[126.915056,37.549202],[126.914828,37.549413],[126.915004,37.549531],[126.914966,37.549574],[126.915534,37.549964]], time: "13분 15초"),
            .init(spotId: 2, name: "정상제의길", roadFile: [[126.915277,37.547834],[126.915321,37.54799],[126.914657,37.548117],[126.914829,37.548661],[126.915056,37.549202],[126.914828,37.549413],[126.915004,37.549531],[126.914966,37.549574],[126.915534,37.549964]], time: "14분 15초"),
        ]
    ) {
        self.roadList = roadList
    }
}

extension RoadListViewModel {
    func addRoad(_ newRoad: [Double:Double]) {
    
    }
    
    func removeRoad(_ removeRoad: Int) {
     
    }
    
    func makeRoad() {
        BaseLocationManager.shared.startUpdatingLocation()
        
        
    }
}
