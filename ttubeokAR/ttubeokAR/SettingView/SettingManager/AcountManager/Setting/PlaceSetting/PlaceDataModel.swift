//
//  PlaceDataModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/18/24.
//


import Foundation

struct PlaceDataModel: Codable, Hashable{
    var check: Bool
    var information: [RegisteredPlaceInfor]?
}


struct RegisteredPlaceInfor: Codable, Hashable{
    var id : Int
    var name : String
    var info : String
    var image : String
}
