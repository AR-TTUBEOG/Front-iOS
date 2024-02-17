//
//  GameManagerModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/15/24.
//

import Foundation


struct RouletteModel: Codable {
    var benefitType: String
    var options: [String]
}

struct ResponseRouletteModel: Codable {
    var check: Bool
    var information: RouletteModelInfor
}


struct RouletteModelInfor: Codable {
    var gameId: Int
    var options: [String]
    var storeId: Int
    var benefits: [Benefit]
}

struct Benefit: Codable {
    var benefitId: Int
    var content: String
    var type: String
}

//MARK: - 선물

struct GifttModel: Codable {
    var timeLimit: String
    var giftCount: Int
    var benefitContent: String
    var benefitType: String

}

struct ResponseGiftModel: Codable {
    var check: Bool
    var information: GiftCheckInfor
}

struct GiftCheckInfor: Codable {
    var gameId: Int
    var benefitId: Int
    var timeLimit: String
    var giftCount: Int
    var benefitContent: String
    var benefitType: String
}

//MARK: - 농구

struct BasketBallModel: Codable {
    var timeLimit: Int
    var ballCount: Int
    var successCount: Int
    var benefitContent: String
    var benefitType: String
}

struct ResponseBasketBallModel: Codable {
    var check: Bool
    var information: BasketBallCheckInfor
}

struct BasketBallCheckInfor: Codable {
    var gameId: Int
    var benefitId: Int
    var storeId: Int
    var timeLimit: Int
    var ballCount: Int
    var successCount: Int
    var benefitContent: String
    var benefitType: String
    
}
