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
    public func checkNicknameAvailability() {
        guard !nickname.isEmpty else {
            isNicknameAvailable = nil
            return
        }
        
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else {
            print("accessToken error")
            return
        }
        
        provider.request(.checkNickname(nickname, token: accessToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let nicknameRedundancy = try JSONDecoder().decode(NicknameRedundancyModel.self, from: response.data)
                    print("4 : 닉네임 체크 -> \(nicknameRedundancy.check)")
                    self?.isNicknameAvailable = nicknameRedundancy.check
                } catch {
                    print("중복성 검사 반응 error : \(error)")
                }
            case .failure(let error):
                print("중복성 검사 요청 error : \(error)")
                
            }
        }
    }
    
    public func sendNickname() {
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else {
            print("accessToken")
            return
        }
        
        provider.request(.finishNickname(nickname, token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let nicknameRedundancy = try JSONDecoder().decode(NicknameInformation.self, from: response.data)
                    print("5. 닉네임 정보 전달 완료 : \(nicknameRedundancy)")
                    
                //TODO: - 닉네임 수정 사항
//                    saveNickname(newNickname: nicknameRedundancy.nickname)
                    
                } catch {
                    print("5-1 : 닉네임 정보 전달 후 디코드 반응 error : \(error)")
                }
            case .failure(let error):
                print("5-2 : 닉네임 정보 전달 요청 error : \(error)")
                
            }
        }
    }
    
    public func saveNickname(newNickname: String) {
        if var session = KeyChainManager.standard.loadSession(for: "userSession") {
            session.nickname = newNickname
            let saved = KeyChainManager.standard.saveSession(session, for: "userSession")
            print("6. 닉네임 키체인 저장 완료 : \(session)")
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
