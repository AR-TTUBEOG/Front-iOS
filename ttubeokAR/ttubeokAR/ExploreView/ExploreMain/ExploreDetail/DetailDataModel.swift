//
//  DetailViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation




/*class DetailViewModel: ObservableObject {
    @Published var storeInfo: StoreInformation?

    func loadStoreData() {
        // API 호출
        let detailInfo = DetailInfo()
    }
} */


//매장 세부사항
struct DetailDataModel: Codable {
    var check: Bool
    var Storeinformation: StoreInformation
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



class DetailInfo {
    var sampleStoreInfo: StoreInformation = StoreInformation(storeId: 1,
                                                             dongareaId: 2,
                                                             userId: 3,
                                                             detailAddress: "힐하우스 A동 301호",
                                                             name: "낙산공원 한양도성길",
                                                             info: "낙산 공원 주변에서 예쁜 야경풍경과 함꼐 하루를 마쳐 봐요!\n다양한 산책로가 존재하고 있습니다!",
                                                             latitude: 37.580468,
                                                             longitude: 127.007849,
                                                             image: "DetailSpace",
                                                             stars: 4.1,
                                                             type: "restaurant",
                                                             benefit: [
                                                                 "giftIcon", "Union"
                                                             ],
                                                             likes: 1000,
                                                             guestbook : 134,
                                                             mark : false)

}
