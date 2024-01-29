//
//  GuestBookModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation
import SwiftUI

//방명록
/*struct Review: Codable {
    var check: Bool //정상응답 여부
    var information: ReviewInformation //데이터를 담고있는 객체
}*/

struct GuestBookModel: Codable {
    var guestbookId: Int
    var storeId: Int
    var userId: Int
    var content: String
    var stars: String
    var image: String
    var userName : String
}



class ReviewInfo {
    static let infos: [GuestBookModel] = [
        GuestBookModel(
            guestbookId: 1,
            storeId: 1,
            userId: 1,
            content: "오늘도 즐거운 산책~!",
            stars: "5",
            image: "DetailViewtest",
            userName: "메타몽"
        ),GuestBookModel(
            guestbookId: 1,
            storeId: 1,
            userId: 2,
            content: "오늘도 즐거운 산책~!",
            stars: "3",
            image: "DetailViewtest",
            userName: "메타몽"
        ),GuestBookModel(
            guestbookId: 1,
            storeId: 1,
            userId: 3,
            content: "오늘도 즐거운 산책~!",
            stars: "4",
            image: "DetailViewtest",
            userName: "메타몽"
        ),GuestBookModel(
            guestbookId: 1,
            storeId: 1,
            userId: 4,
            content: "오늘도 즐거운 산책~!",
            stars: "5",
            image: "DetailViewtest",
            userName: "메타몽"
        )
        
    ]

}
