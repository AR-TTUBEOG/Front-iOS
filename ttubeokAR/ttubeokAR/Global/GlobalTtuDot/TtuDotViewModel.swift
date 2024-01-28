//
//  TtuluttuDotViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

class TtuDotViewModel: ObservableObject {
    //MARK: - Property
    @Published var angle: Double = 0
    @Published var sections: [TtuDotSection]
    @Published var selectedSection: String?
    @Published var showPlaceRegistrationView = false

    //MARK: - Init
    init(sharedTabInfo: SharedTabInfo) {
        sections = [
            TtuDotSection(command: AddLocationCommand(sharedTabInfo: sharedTabInfo), title: "장소 추가", imageName: "AddLocation"),
            TtuDotSection(command: ARCommand(), title: "AR 보기", imageName: "ARBtn"),
            TtuDotSection(command: MyTicketCommand(), title: "내 쿠폰", imageName: "MyTicket"),
            TtuDotSection(command: SettingsCommand(), title: "마이 페이지", imageName: "myPage"),
            TtuDotSection(command: SettingsCommand(), title: "환경 설정", imageName: "OptionBtn")
        ]
    }
    
    public func selectSection(at index: Int) {
        if index >= 0 && index < sections.count {
            sections[index].command.execute()
        }
    }
}
