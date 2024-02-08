//
//  Icon.swift
//  ttubeokAR
//
//  Created by Subeen on 1/15/24.
//

import Foundation
import SwiftUI

enum Icon: String {
    
    // MARK: - Coupon
    case couponBackground = "couponBackground"
    case couponBtnpdf = "couponBtnpdf"
    
    // MARK: - GlobalSearchBarControl
    case book = "book"
    case drink = "drink"
    case logo = "logo"
    case option = "option"
    case restaurant = "restaurant"
    case search = "search"
    case slider = "slider"
    case trail = "trail"
    
    // MARK: - Image
    case bell = "bell"
    case checkbox_filled_purple = "checkbox_filled_purple"
    case chevronDown = "chevronDown"
    case coupon = "coupon"
    case couponOnePlusOne = "couponOnePlusOne"
    case couponPercent = "couponPercent"
    case couponPresent = "couponPresent"
    case cross = "cross"
    case document = "document"
    case game = "game"
    case headphonesGray = "headphonesGray"
    
    case headphonesPurple = "headphonesPurple"
    case heart = "heart"
    case lightOn = "lightOn"
    case notepad = "notepad"
    case onePlusOne = "onePlusOne"
    case present = "present"
    case restaurant_map = "restaurant_map"
    case restaurant_map2 = "restaurant_map2"
    case star_filled = "star_filled"
    case star = "star"
    case start = "start"
    
    case step = "step"
    case top = "top"
    case trailMap = "trailMap"
    case waste = "waste"
    // MARK: - ExploreView
    
    case banner = "banner"
    case distance = "distance"
    case reviewCount = "reviewCount"
    case spaceTest = "spaceTest"
    case starRating = "starRating"
    case time = "time"
    case Vector = "Vector"
    case Vector2 = "Vector2"
    case store = "store"
    case tree = "tree"
    case heartBold = "heartBold"
    case Subtract = "Subtract"
    case star2 = "star2"
    case time2 = "time2"
    case distance2 = "distance2"
    case DetailViewtest = "DetailViewtest"
    case Setting = "Setting"
    case pressedheart = "pressedheart"
    case unpressedheart = "unpressedheart"
    
    // MARK: - Login
    case warning = "nameWarning"
    case nameCheck = "nameCheck"
    case apple = "appleLogin"
    case kakao = "kakaoLogin"
    case nickname = "nicknameView"
    case loginBackground = "loginViewImage"
    case checkbox_filled = "checkbox_filled"
    case checkbox = "checkbox"
    case logoImage = "logoImage"
    
    // MARK: - Navigation bar
    case arrowLeft = "arrowLeft"
    case chevronLeft = "chevronLeft"
    
    // MARK: - Setting
    case chevronRight = "chevronRight"
    
    // MARK: - Tab Button
    case ExploreTabButton = "ExploreTabButton"
    case mapTabButton = "mapTabButton"
    
    // MARK: - TtuDotBtn
    case AddLocation = "AddLocation"
    case ARBtn = "ARBtn"
    case myPage = "myPage"
    case MyTicket = "MyTicket"
    case OptionBtn = "OptionBtn"
    
    //MARK: - PlaceSetting
    case PlaceBackground = "RegisterBackground"
    case RegisterBackground2 = "RegisterBackground2"
    case marketGroup = "marketGroup"
    case marketIcon = "marketIcon"
    case walkGroup = "walkGroup"
    case walkIcon = "walkIcon"
    case closeView = "closeView"
    case searchAddress = "searchAddress"
    case examplePlace = "examplePlace"
    case examplePlace2 = "examplePlace2"
    case camera = "camera"
    case xButton = "Xbutton"
    case placeFinish = "placeFinish"
    case whiteDrink = "whiteDrink"
    case whiteRest = "whiteRest"
    case exampleMarket = "exampleMarket"
    case exampleMarket2 = "exampleMarket2"
    
    
    //MARK: - Game
    case checkCircle = "checkCircle"
    case gameBox = "gameBox"
    case gameCoupon = "gameCoupon"
    case gameOnePlus = "gameOnePlus"
    
    var image: Image {
        return Image(self.rawValue)
    }
    //MARK: - GuestBook
    case closeIcon = "closeIcon"
    case ImagePlus = "ImagePlus"
    case StarFilled = "StarFilled"
    case emptyStar = "emptyStar"
    case CommentIcon = "CommentIcon"
}
