//
//  NicknameSettingViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/18/24.
//

import Foundation
import Moya

class NicknameSettingViewModel: ObservableObject {
    @Published var nickname: String = "" {
        didSet {
            checkNicknameLength()
        }
    }
    @Published var isNicknameValid: Bool = true
    @Published var isNicknameAvailable: Bool? = nil
    private let provider = MoyaProvider<NicknameRedundancyService>()
    
    public func checkNicknameAvailability() {
        guard !nickname.isEmpty else {
            isNicknameAvailable = nil
            return
        }
        
        provider.request(.checkNicname(nickname)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let nicknameRedundancy = try response.map(NicknameRedundancyModel.self)
                    self?.isNicknameAvailable = nicknameRedundancy.availability
                } catch {
                    print("중복성 검사 반응 error : \(error.localizedDescription)")
                }
            case .failure(let error):
                print("요청 error : \(error.localizedDescription)")
            }
        }
    }
    
    private func checkNicknameLength() {
        isNicknameValid = nickname.count >= 2 && nickname.count <= 10
    }
}
