//
//  NicknameSettingViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import Foundation

class NicknameSettingViewModel: ObservableObject {
    @Published var nickname: String = "" {
        didSet {
            checkNicknameLength()
        }
    }
    @Published var isNicknameValid: Bool = true
    @Published var isNicknameAvailable: Bool? = nil
    @Published var isCheckingNickname: Bool = false
    @Published var changeMainRoot: Bool = false
    
    public func checkNicknameAvailability() {
        guard !nickname.isEmpty else {
            isNicknameAvailable = nil
            return
        }
        
        isCheckingNickname = true
    }
    
    private func checkNicknameLength() {
        isNicknameValid = nickname.count >= 2 && nickname.count <= 10
    }
    
    public func submitNickname() {
        print("서버 전송: \(nickname)")
        self.changeMainRoot = true
    }
}
