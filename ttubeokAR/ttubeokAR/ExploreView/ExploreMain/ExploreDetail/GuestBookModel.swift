//
//  GuestBookModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import Foundation

struct GuestBookModel: Codable {
    var guestbookId: Int
    var storeId: Int
    var userId: Int
    var content: String
    var stars: String
    var image: String
    var userName : String
}

