//
//  AddLocation.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

/// 뚜닷 장소 추가 커맨드
/**
 뚜닷에 연결된 모든 버튼들은 현재의 root를 탐색하고, 돌아와야하기 때문에 아래의 형식을
 지켜서 사용할 것!
 */
class AddLocationCommand: TtuDotModel {
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
        let newRootView = UIHostingController(rootView: PlaceRegistrationView(lastedSelectedTab: getCurrentTab))
        appDelegate?.changeRootViewController(newRootView, animated: true)
    }
}
