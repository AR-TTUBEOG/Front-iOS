//
//  DetailViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation

//매장 세부사항 조회 api
struct DetailDataModel: Codable {
    var check: Bool
    var information: [StoreInformation]
}

struct StoreInformation: Codable {
    var storeId: Int
    var dongareaId: Int
    var userId: Int
    var detailAddress: String
    var name: String
    var info: String
    var latitude: Double
    var longitude: Double
    var image: String
    var stars: Float
    var type: String
    var benefit: [String]
    var likes: Int
    var guestbook : Int
    var mark : Bool
}
