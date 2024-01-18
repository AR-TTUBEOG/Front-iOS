//
//  NicknameSettingViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import Foundation

class NicknameSettingViewModel: ObservableObject {
    @Published var nickname: String = ""
    @Published var submittedNickname: Bool = false
    
    public func submitNickname() {
        print("서버 전송")
        self.submittedNickname = true
    }
}
