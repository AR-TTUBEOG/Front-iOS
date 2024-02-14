//
//  SharedTabInfo.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import Foundation
import SwiftUI

class SharedTabInfo: ObservableObject {
    @Published var currentTab: Int
    
    init(currentTab: Int = 1) {
        self.currentTab = currentTab
    }
}
