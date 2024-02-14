//
//  RecommendedSpaceCardViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/15/24.
//

import Foundation
import CoreLocation
import Moya

class RecommendedSpaceCardViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //MARK: - API
    private let provider = MoyaProvider<ExploreAPITarget>()
    var exploreDetailInfor: ExploreDetailInfor?
    init(exploreDetailInfor: ExploreDetailInfor) {
        self.exploreDetailInfor = exploreDetailInfor
    }
    
    //MARK: - 이미지 좋아요
    @Published var isFavorited: Bool = false
    @Published var placeType: PlaceTypeValue? = nil
    
    
    public func changePlaceType() {
        if (self.exploreDetailInfor?.placeType.spot) != nil {
            self.placeType = .spot
        } else if (self.exploreDetailInfor?.placeType.store) != nil {
                self.placeType = .store
            }
        }
    
    public func checkLike() {
        if self.isFavorited {
            sendLike()
        }
    }
    
    public func sendLike() {
        
        guard let detailInfo = self.exploreDetailInfor else { return }
        
        switch self.placeType {
        case .spot:
            self.likeWalkWay(spotId: detailInfo.id)
        case .store:
            self.likeStore(storeId: detailInfo.id)
        case .none:
            print("error")
        }
    }
    
    
    var favoriteImageName: String {
        return isFavorited ? "checkHeart" : "unCheckHeart"
    }
    
    public func likeWalkWay(spotId: Int) {
        provider.request(.likeWalkWay(spotId: spotId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(WalkWayLikeModel.self, from: response.data)
                    print(decodedResponse)
                } catch {
                    print("산책로 error")
                }
            case .failure(let error):
                print("산책로 error : \(error)")
            }
        }
    }
    
    public func likeStore(storeId: Int) {
        provider.request(.likeStoreData(storeId: storeId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(StoreLikeModel.self, from: response.data)
                    print(decodedResponse)
                } catch {
                    print("매장 error")
                }
            case .failure(let error):
                print("매장 error: \(error)")
            }
        }
    }
    
    //MARK: - 리뷰 카운트
    
    public func formattedReviewCount(_ count: Int) -> String {
        return count > 999 ? "999+" : "\(count)"
    }
    
    //MARK: - 거리 및 시간 계산
    
    @Published var distance: CLLocationDistance = 0
    @Published var estimatedTime: TimeInterval = 0
    
    
}
