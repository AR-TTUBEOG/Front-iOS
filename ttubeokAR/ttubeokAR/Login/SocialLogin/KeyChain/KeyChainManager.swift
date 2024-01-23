//
//  KeyChainManager.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/23/24.
//

import Foundation
import Security

/// 로그인 시 전달받은 토큰 저장하기
class KeyChainManager {
    
    //MARK: - Propety
    static let stadard = KeyChainManager()
    
    //MARK: - KeyChainFunction
    
    /// 토큰 키 체인 등록
    /// - Parameters:
    ///   - data: 전달받은 토큰값 입력
    ///   - key: 토큰 값에 쌍으로 매칭될 키값
    /// - Returns: 저장 되었는지 아닌지 참 거짓으로 반환
    public func save(_ data: Data, for key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil) == noErr
    }
    
    /// 저장된 토큰을 불러와 사용한다.
    /// - Parameter key: 불러올 토큰 값에 연결된 키값
    /// - Returns: 키값에 해당하는 토큰 불러오기
    public func load(key: String) -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == noErr, let data = item as? Data else {
            return nil
        }
        
        return data
    }
    
    /// 토큰을 삭제한다(회원 탈퇴 시 사용될 함수)
    /// - Parameter key: 지우고자 하는 토큰의 키값
    public func delete(key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
