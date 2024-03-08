//
//  RoadViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 2/13/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI
import MapKit

class RoadViewModel: ObservableObject {
    
    private let authPlugin: AuthPlugin
    private let roadProvider: MoyaProvider<RoadService>
    
    init() {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.roadProvider = MoyaProvider<RoadService>(plugins: [authPlugin])
    }
    
    @Published var responseRoadModel: ResponseRoadModel?
    @Published var history: [CLLocationCoordinate2D]?
    
//    var roadCancellable: AnyCancellable
    var curretnPage = 0
    
    func toViewModel(_ list: ResponseRoadModel) {
        self.responseRoadModel = list
    }
    
    //MARK: - 토큰 불러오기
    /// 액세스 토큰 불러오기
    /// - Returns: 햔재 액세스 토큰
    private func loadAccessToken() -> String? {
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else {
            return "토큰 정보 에러"
        }
        
        return accessToken
    }
    
    /// post 산책로 등록
    public func createRoad(requestRoadModel: RequestRoadModel) {
        guard let accessToken = KeyChainManager.standard.getAccessToken(for: "userSession") else {
            print("create road 중 액세스 토큰 가져오기 오류")
            return
        }
        
        roadProvider.request(.postRoad(requestRoadModel, token: loadAccessToken() ?? "road 토큰정보 없음")) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseRoadModel.self, from: response.data)
                    self.toViewModel(decodedData)
                    print("Road 등록 완료 후 해독 완료 ")
                } catch {
                    
                    print("Road 등록 decode 에러 : \(error)")
                }
            case .failure(let error):
                print("Road 네트워크 error: \(error)")
            }
        }
        
    }
    
    /// get
    public func findRoadByStoreId(storeId: Int, pageNum: Int, token: String) {
        guard let accssToken = KeyChainManager.standard.getAccessToken(for: "userSession") else {
            print("find road by store id 중 액세스 토큰 가져오기 오류")
            return
        }
        
        roadProvider.request(.getStoreRoad(storeId: storeId, pageNum: pageNum, token: loadAccessToken() ?? "road 토큰정보 없음")) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseRoadModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if pageNum == 0 {
                            self?.responseRoadModel = decodedData
                            print("road store id 디코드 완료")
                        } else {
                            self?.responseRoadModel?.information.append(contentsOf: decodedData.information)
                            print("road store id 추가 페이지 디코드 완료")
                        }
                        self?.curretnPage = pageNum
                    }
                } catch {
                    if let rawResponse = String(data: response.data, encoding: .utf8) {
                        print("road response: \(rawResponse)")
                    }
                }
            case .failure(let error):
                print("전체 선택네트워크 error \(error.localizedDescription)")
            }
        }
    }
    
    /// get
    public func findRoadBySpotId(spotId: Int, pageNum: Int, token: String) {
        guard let accssToken = KeyChainManager.standard.getAccessToken(for: "userSession") else {
            print("find road by store id 중 액세스 토큰 가져오기 오류")
            return
        }
        
        roadProvider.request(.getSpotRoad(spotId: spotId, pageNum: pageNum, token: loadAccessToken() ?? "road 토큰정보 없음")) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(ResponseRoadModel.self, from: response.data)
                    DispatchQueue.main.async {
                        if pageNum == 0 {
                            self?.responseRoadModel = decodedData
                            print("8: 전체조회 1페이지 디코드 완료")
                        } else {
                            self?.responseRoadModel?.information.append(contentsOf: decodedData.information)
                            print("8: 전체 조회 추가 페이지 디코드 완료")
                        }
                        self?.curretnPage = pageNum
                    }
                } catch {
                    if let rawResponse = String(data: response.data, encoding: .utf8) {
                        print("road response: \(rawResponse)")
                    }
                }
            case .failure(let error):
                print("전체 선택네트워크 error \(error.localizedDescription)")
            }
        }
    }
}
    
    
//case postRoad(RequestRoadModel, token: String)
//case getStoreRoad(storeId: Int, pageNum: Int, token: String)
//case getSpotId(spotId: Int, pageNum: Int, token: String)
//case deleteRoad(roadId: Int, token: String)

