//
//  PlaceViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 1/21/24.
//

import Foundation
import Moya

class PlaceViewModel : ObservableObject {
    //MARK: - Moodel
    var placeData : PlaceDataModel?
    var registeredPlaceInfor: RegisteredPlaceInfor?
    
    //MARK: - API
    private let placeProvider = MoyaProvider<PlaceAPITarget>()
    
    
    /// 산책로 
    private func WalkwayPlace() {
        
        guard let accessToken = KeyChainManager.standard.getNickname(for: "userSession") else { return }
        
        placeProvider.request(.RegisteredPlace(token: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(PlaceDataModel.self, from: response.data)
                    self.placeData = decodedResponse
                    print("내 산책로 조회 성공")
                } catch {
                    print("내 산책로 디코드 error")
                }
            case .failure(let error):
                print("내 산책로 네트워크 error : \(error)")
            }
        }
    }
    
    
}



