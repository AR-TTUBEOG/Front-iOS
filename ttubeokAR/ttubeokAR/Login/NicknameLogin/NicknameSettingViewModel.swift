//
//  NicknameSettingViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import Foundation
import Moya

/// 닉네임 중복검사 뷰에서 활용하는 뷰모델
class NicknameSettingViewModel: ObservableObject {
    @Published var nickname: String = "" {
        didSet {
            checkNicknameLength()
        }
    }
    @Published var isNicknameValid: Bool = true
    @Published var isNicknameAvailable: Bool? = nil
    private let provider = MoyaProvider<NicknameRedundancyService>()
    
    /// 닉네임 중복검사 API 요청
    //TODO: - API 호출 시 토큰을 필요로 하는지 확인하기
    public func checkNicknameAvailability() {
        guard !nickname.isEmpty else {
            isNicknameAvailable = nil
            return
        }
        
        guard let accessToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("accessToken")
            return
        }
        
        provider.request(.checkNickname(nickname, token: accessToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let nicknameRedundancy = try JSONDecoder().decode(NicknameRedundancyModel.self, from: response.data)
                    self?.isNicknameAvailable = nicknameRedundancy.information.isUsed
                    print("중복검사 진행함")
                } catch {
                    print("중복성 검사 반응 error : \(error.localizedDescription)")
                }
            case .failure(let error):
                print("요청 error : \(error.localizedDescription)")
            }
        }
    }
    
    public func saveNickname(newNickname: String) {
        if var session = KeyChainManager.stadard.loadSession(for: "userSession") {
            session.nickname = newNickname
            let saved = KeyChainManager.stadard.saveSession(session, for: "userSession")
            if !saved {
                print("닉네임 세션 실패")
            }
        }
    }
    
    /// 닉네임 길이 검사
    private func checkNicknameLength() {
        isNicknameValid = nickname.count >= 2 && nickname.count <= 10
    }
}
