//
//  RecommendSpaceModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation

struct RecommendedSpaceModel : Codable {
    var placeName: String //
    var placePhoto: String //
        //설명 ->
    var starRating: Double
    var distance: Double // 임시 거리 변수
    //var placePoint: [point]
    var time: String
    var reviewCount: Int
    var isFavorited: Bool
    var placeType : [place]
    
    enum CodingKeys: String, CodingKey {
           case placeName = "name"
           case placePhoto = "photo_url"
           case starRating = "rating"
           case distance = "distance_from_user"
           case time = "time_open"
           case reviewCount = "reviews_count"
           case isFavorited = "favorited"
           case placeType = "place_type"
       }
    
}


//장소 유형
public struct place: Codable {
    var walkingSpot: Bool
    var storeSpot: Bool

    enum CodingKeys: String, CodingKey {
        case walkingSpot = "walking_spot"
        case storeSpot = "store_spot"
    }
}

//가게 유형
struct Store {
    var restaurant : Bool
    var cafe : Bool
}

//struct point {
//    var lat //위도
//    var lng //경도
//}





class Info {
    let falsePlace = place(walkingSpot: false, storeSpot: false)
    let falseStore = Store(restaurant: false, cafe: false)
    
    var spaces: [RecommendedSpaceModel] = [
        RecommendedSpaceModel(
            placeName: "낙산공원 한양도성길",
            placePhoto: "spaceTest",
            starRating: 4.5,
            distance: 2.3,
            time: "15",
            reviewCount: 123,
            isFavorited: false,
            placeType:[place(walkingSpot: true, storeSpot: false)]
        ) ,  RecommendedSpaceModel(
            placeName: "place2",
            placePhoto: "spaceTest",
            starRating: 4.5,
            distance: 2.3,
            time: "15",
            reviewCount: 15,
            isFavorited: false,
            placeType:[place(walkingSpot: false, storeSpot: true)]
        )  ,  RecommendedSpaceModel(
            placeName: "place3",
            placePhoto: "spaceTest",
            starRating: 4.5,
            distance: 2.3,
            time: "15",
            reviewCount: 15,
            isFavorited: false,
            placeType:[place(walkingSpot: false, storeSpot: true)]
        ) ,  RecommendedSpaceModel(
            placeName: "place4",
            placePhoto: "spaceTest",
            starRating: 4.5,
            distance: 2.3,
            time: "15",
            reviewCount: 15,
            isFavorited: false,
            placeType:[place(walkingSpot: true, storeSpot: false)]
        )
        ,  RecommendedSpaceModel(
           placeName: "place5",
           placePhoto: "spaceTest",
           starRating: 4.5,
           distance: 2.3,
           time: "15",
           reviewCount: 15,
           isFavorited: false,
           placeType:[place(walkingSpot: true, storeSpot: false)]
       )
        ,  RecommendedSpaceModel(
           placeName: "place6",
           placePhoto: "spaceTest",
           starRating: 4.5,
           distance: 2.3,
           time: "15",
           reviewCount: 15,
           isFavorited: false,
           placeType:[place(walkingSpot: true, storeSpot: false)]
       )
        
    ]
}
