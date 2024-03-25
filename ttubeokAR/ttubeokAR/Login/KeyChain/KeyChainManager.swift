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
    static let standard = KeyChainManager()
    
    //MARK: - KeyChainFunction
    
    /// 토큰 키 체인 등록
    /// - Parameters:
    ///   - data: 전달받은 토큰값 입력
    ///   - key: 토큰 값에 쌍으로 매칭될 키값
    /// - Returns: 저장 되었는지 아닌지 참 거짓으로 반환
    private func save(_ data: Data, for key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil) == noErr
    }
    
    /// 저장된 토큰을 불러와 사용한다.
    /// - Parameter key: 불러올 토큰 값에 연결된 키값
    /// - Returns: 키값에 해당하는 토큰 불러오기
    private func load(key: String) -> Data? {
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
    private func delete(key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    //MARK: - 세션 설정
    
    public func saveSession(_ session: UserSession, for key: String) -> Bool {
        guard let data = try? JSONEncoder().encode(session) else { return false }
        return save(data, for: key)
    }
    
    public func loadSession(for key: String) -> UserSession? {
        guard let data = load(key: key),
              let session = try? JSONDecoder().decode(UserSession.self, from: data) else { return nil }
        return session
    }
    
    public func deleteSession(for key: String) {
        delete(key: key)
    }
    
    //MARK: - 세션 사용하여 값 얻기
    public func getAccessToken(for key: String) -> String? {
        guard let session = loadSession(for: key) else { return nil }
        return session.accessToken
    }
    public func getRefreshToken(for key: String) -> String? {
        guard let session = loadSession(for: key) else { return nil }
        return session.refreshToken
    }
    public func getNickname(for key: String) -> String? {
        guard let session = loadSession(for: key) else { return nil }
        return session.nickname
    }
    
    public func firstAccessSaveSession(accessToken: String, refreshToken: String) {
        let session = UserSession(accessToken: accessToken, refreshToken: refreshToken, nickname: nil)
        let saved = KeyChainManager.standard.saveSession(session, for: "userSession")
        if !saved {
            print("세션 저장 실패")
        }
    }
    
    public func initialRefreshSaveToken(accessToken: String, refreshToken: String, for key: String) {
        guard var session = loadSession(for: key) else { return }
        
        session.accessToken = accessToken
        session.refreshToken = refreshToken
        
        let saved = KeyChainManager.standard.saveSession(session, for: key)
        if saved {
            print("세션이 초기화되어 저장되었습니다.")
        }
    }
}