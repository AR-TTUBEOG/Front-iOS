//
//  DetailViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation

//방명록
struct Review: Codable {
    var check: Bool //정상응답 여부
    var information: ReviewInformation //데이터를 담고있는 객체
}

struct ReviewInformation: Codable {
    var guestbookId: Int //방명록 아이디
    var storeId: Int //매장 아이디
    var userId: Int //등록유저 아이디
    var content: String //방명록 내용
    var stars: String //별점
    var image: String //이미지
}


//매장 세부사항
struct StoreInfo: Codable {
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
    var latitude: String
    var longitude: String
    var image: String
    var stars: Float
    var type: String
    var benefit: [String]
    var likes: Int
    var guestbook : Int
}





class DetailInfo {
    var SampleStoreInfo: StoreInformation

    init() {
        self.SampleStoreInfo = StoreInformation(
            storeId: 1,
            dongareaId: 2,
            userId: 3,
            detailAddress: "힐하우스 A동 301호",
            name: "낙산공원 한양도성길",
            info: "낙산 공원 주변에서 예쁜 야경풍경과 함꼐 하루를 마쳐 봐요!\n다양한 산책로가 존재하고 있습니다!",
            latitude: "15.944",
            longitude: "15.955",
            image: "DetailSpace",
            stars: 4.1,
            type: "restaurant",
            benefit: [
                "giftIcon", "coupon", "Union"
            ],
            likes: 123,
            guestbook : 134
        )
    }
}
