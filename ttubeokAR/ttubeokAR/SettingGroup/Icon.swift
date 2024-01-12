//
//  Icon.swift
//  ttubeokAR
//
//  Created by Subeen on 1/11/24.
//

import Foundation
import SwiftUI

enum Icon: String {
    // Global SearchBar Control
    case book = "book"
    case dring = "drink"
    case logo = "logo"
    case option = "option"
    case restaurant = "restaurant"
    case search = "search"
    case trail = "trail"
    
    // TtuDotBtn
    case AddLocation = "AddLocation"
    case ARBtn = "ARBtn"
    case myPage = "myPage"
    case MyTicket = "MyTicket"
    case OptionBtn = "OptionBtn"
    
    // Icon
    case bell = "bell"
    case beverage_map = "beverage_map"
    case checkbox = "checkbox"
    case chevronDown = "chevronDown"
    case chevronLeft = "chevronLeft"
    case console = "console"
    case coupon = "coupon"
    case cross = "cross"
    case document = "document"
    case headphonesBlack = "headphonesBlack"
    case headphonesGray = "headphonesGray"
    case headphonesPurple = "headphonesPurple"
    case heart = "heart"
    case lightOn = "lightOn"
    case notepad = "notepad"
    case onePlusOne = "onePlusOne"
    case present = "present"
    case restaurant_map = "restaurant_map"
    case star_filled = "star_filled"
    case star = "star"
    case step = "step"
    case trailMap = "trailMap"
    case waste = "waste"
    
    
    var image: Image {
        return Image(self.rawValue)
    }
}


