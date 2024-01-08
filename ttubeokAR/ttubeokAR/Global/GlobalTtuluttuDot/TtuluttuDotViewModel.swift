//
//  TtuluttuDotViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

class TtuluttuDotViewModel: ObservableObject {
    @Published var angle: Double = 0
    var commands: [TtuluttuDotCommand]
    var sections: [String]
    
    init() {
        commands = [AddLocationCommand(), ARCommand(), MyTicketCommand(), SettingsCommand()]
        sections = ["장소 추가", "AR 보기", "내 쿠폰", "환경설정"]
    }
    
    public func selectSection(index: Int) {
        commands[index].execute()
    }
}
