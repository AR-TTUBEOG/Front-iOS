//
//  EasySeachModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/7/24.
//

import Foundation

struct SearchButtonModel {
    var title: String
    var buttonImage: String
    var action: () -> Void
}

enum CurrentView {
    case exploreView
    case mapView
}
