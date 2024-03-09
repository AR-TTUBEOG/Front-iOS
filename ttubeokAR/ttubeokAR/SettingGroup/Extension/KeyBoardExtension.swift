//
//  KeyBoardSetting.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import SwiftUI


extension View {
    func keyboardResponsive() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil)
    }
}

