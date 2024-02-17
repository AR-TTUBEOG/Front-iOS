//
//  ExploreViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation
import Moya
import Combine

class ExploreViewModel: ObservableObject {
    //MARK: - API
    
    private let authPlugin: AuthPlugin
    private let searchProvider: MoyaProvider<SearchAPITarget>
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.searchProvider = MoyaProvider<SearchAPITarget>(plugins: [authPlugin])
    }
    //MARK: - Moodel
    
    @Published var exploreData: ExploreDataModel?
    @Published var currentSearchType: SearchType = .all
    
    var curretnPage = 0
  
    // MARK: - 페이징
    
    public func decisionSearchType(_ searchType: SearchType) {
        switch searchType {
        case .all:
            self.currentSearchType = .all
        case .latest:
            self.currentSearchType = .latest
        case .distance:
            self.currentSearchType = .distance
        case .recommended:
            self.currentSearchType = .recommended
        }
    }
    
    public func fetchDataSearch(_ searchType: SearchType, page: Int) {
        switch searchType {
        case .all:
            fetchExploreDataAll(page: page)
        case .latest:
            fetchExploreDataLatest(page: page)
        case .distance:
            fetchExploreDataDistance(page: page)
        case .recommended:
            fetchExploreDataRecommend(page: page)
        }
        self.curretnPage = page
    }
    
    //MARK: - 검색 타입에 따른 API 호출 함수
    
    public func resetPage() {
        curretnPage = 0
    }
    
    public func fetchExploreDataAll(page: Int) {
        print("8 :전체 선택 API 호출")
        
        guard let accssToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("전체 검색 중 액세스 토큰 가져오기 오류")
            return
        }
        
        searchProvider.request(.searchAll(page: page, size: 9, token: accssToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    print("사용 액세스 토큰 : \(accssToken)")
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 0 {
                            self?.exploreData = decodedData
                            print("8: 전체조회 1페이지 디코드 완료")
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                            print("8: 전체 조회 추가 페이지 디코드 완료")
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    if let rawResponse = String(data: response.data, encoding: .utf8) {
                        print("전체 조회 response: \(rawResponse)")
                    }
                }
            case .failure(let error):
                print("전체 선택네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataLatest(page: Int) {
        print("최신순 선택 API 호출")
        
        guard let accssToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("최신순 중 액세스 토큰 가져오기 오류")
            return
        }
        
        searchProvider.request(.searchLatest(page: page, size: 9, token: accssToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 0 {
                            self?.exploreData = decodedData
                            print("8: 최신순 1페이지 디코드 완료")
                            print(self?.exploreData)
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                            print("8: 최신순 조회 추가 페이지 디코드 완료")
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("최신순 error: \(error)")
                }
            case .failure(let error):
                print("최신순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataDistance(page: Int) {
        print("거리순 선택 API 호출")
        
        guard let accssToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("거리순 중 액세스 토큰 가져오기 오류")
            return
        }
        
        searchProvider.request(.searchDistance(page: page, size: 9, token: accssToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 0 {
                            self?.exploreData = decodedData
                            print("8: 거리순 1페이지 디코드 완료")
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                            print("8: 거리순 조회 추가 페이지 디코드 완료")
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("거리순 error: \(error)")
                }
            case .failure(let error):
                print("거리순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataRecommend(page: Int) {
        print("추천순 선택 API 호출")
        
        guard let accssToken = KeyChainManager.stadard.getAccessToken(for: "userSession") else {
            print("추천순 중 액세스 토큰 가져오기 오류")
            return
        }
        
        searchProvider.request(.searchRecommend(page: page, size: 9, token: accssToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 0 {
                            self?.exploreData = decodedData
                            print("8: 추천순 1페이지 디코드 완료")
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                            print("8: 추천순 조회 추가 페이지 디코드 완료")
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("추천순 error: \(error)")
                }
            case .failure(let error):
                print("추천순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
}
