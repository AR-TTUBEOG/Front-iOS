//
//  RouteViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 1/24/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

class RouteViewModel: ObservableObject {
    
    @Published var routeModel: RouteResponse?
    
    var routeCancellable: AnyCancellable?
    
    func getRouteToViewModel(_ list: RouteResponse) {
        self.routeModel = list
    }
    
    func routeResponse(origin_lon: Double, origin_lat: Double, dest_lon: Double, dest_lat: Double) {
        if let cancellable = routeCancellable {
            cancellable.cancel()
        }
        
        let provider = MoyaProvider<RouteService>()
    //http://router.project-osrm.org/route/v1/foot/127.105399,37.3595704;127.108081,37.363186?overview=false&steps=true
        routeCancellable = provider.requestPublisher(.getRoute(origin_lon: origin_lon, origin_lat: origin_lat, dest_lon: dest_lon, dest_lat: dest_lat))
            .compactMap { $0.data }
            .receive(on: DispatchQueue.main)
            .decode(type: RouteResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("Network Error \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] model in
                self?.getRouteToViewModel(model)
                print("경로 \(model)")
            })
    }
    
    
}
