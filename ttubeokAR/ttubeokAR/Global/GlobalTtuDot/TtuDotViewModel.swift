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

    //MARK: - Init
    /// 뚜닷에 사용되는 모델 초기화 및 정의
    /// - Parameter sharedTabInfo: 선택된 탭을 추적하고 전달하기 위한 파라미터
    init(sharedTabInfo: SharedTabInfo) {
        sections = [
            TtuDotSection(command: AddLocationCommand(sharedTabInfo: sharedTabInfo), title: "장소 추가", imageName: "AddLocation"),
            TtuDotSection(command: ARCommand(), title: "AR 보기", imageName: "ARBtn"),
            TtuDotSection(command: MyTicketCommand(sharedTabInfo: sharedTabInfo), title: "내 쿠폰", imageName: "MyTicket"),
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
