//
//  ARCommand.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

class ARCommand: TtuDotModel {
    var sharedTabInfo: SharedTabInfo
    var onExecute: (() -> Void)?
    
    init(sharedTabInfo: SharedTabInfo) {
        self.sharedTabInfo = sharedTabInfo
    }
    
    var getCurrentTab: Int {
        return sharedTabInfo.currentTab
    }
    
    func execute() {
        onExecute?()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let newRootView = UIHostingController(rootView: ContentView(lastedTab: getCurrentTab))
        appDelegate?.changeRootViewController(newRootView, animated: true)
    }
}
