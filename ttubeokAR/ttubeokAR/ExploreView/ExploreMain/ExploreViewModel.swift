//
//  ExploreViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/15/24.
//

import Foundation
import CoreLocation
import Moya
import Combine

class ExploreViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    //MARK: - API
    
    private let searchProvider = MoyaProvider<SearchAPITarget>()
    
    //MARK: - Moodel
    
    var exploreData: ExploreDataModel?
    
    @Published var currentSearchType: SearchType = .all
    var curretnPage = 1
    
    
    /// 장소 타입에 따른 API 호출
    
    
    /// 장소 타입에 따라 좋아요 버튼 작동
   
    
    
    /// 산책로 좋아요 버튼 API 호출
    /// - Parameter spotId: 산책로 아이디 제공할 것
  
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
        curretnPage = 1
    }
    
    public func fetchExploreDataAll(page: Int) {
        print("전체 선택 API 호출")
        searchProvider.request(.searchAll(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    if let rawResponse = String(data: response.data, encoding: .utf8) {
                        print("Raw JSON response: \(rawResponse)")
                    }
                }
            case .failure(let error):
                print("전체 선택네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataLatest(page: Int) {
        print("최신순 선택 API 호출")
        searchProvider.request(.searchLatest(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("최신순 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("최신순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataDistance(page: Int) {
        print("거리순 선택 API 호출")
        searchProvider.request(.searchDistance(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("거리순 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("거리순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    public func fetchExploreDataRecommend(page: Int) {
        print("추천순 선택 API 호출")
        searchProvider.request(.searchRecommend(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ExploreDataModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if page == 1 {
                            self?.exploreData = decodedData
                        } else {
                            self?.exploreData?.information.append(contentsOf: decodedData.information)
                        }
                        self?.curretnPage = page
                    }
                } catch {
                    print("추천순 error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("추천순 네트워크 error \(error.localizedDescription)")
            }
        }
    }
}
