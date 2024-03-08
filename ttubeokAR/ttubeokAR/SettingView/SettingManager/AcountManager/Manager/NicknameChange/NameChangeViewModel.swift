//
//  NameChangeViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/15/24.
//

import Foundation
import SwiftUI

//MARK: - 닉네임 변경 창 ViewModel
class NameChangeViewModel: ObservableObject{
    @State var nickname: String = ""
    @State var isValid: Bool = true
    
    
    public func getCurrentNickname() -> String {
        if let name = KeyChainManager.standard.getNickname(for: "userSession") {
            return name
        } else {
            return "닉네임 정보 없음"
        }
    }
}
