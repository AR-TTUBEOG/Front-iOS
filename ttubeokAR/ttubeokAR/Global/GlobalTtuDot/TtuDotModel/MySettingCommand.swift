//
//  MySettingCommand.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/15/24.
//

import Foundation
import SwiftUI

class MySettingCommand: TtuDotModel {
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
        let newRootView = UIHostingController(rootView: AccountSettingView(lastedTab: getCurrentTab))
        appDelegate?.changeRootViewController(newRootView, animated: true)
    }

}
