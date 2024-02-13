//
//  ReverseGeocodingService.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation
import Moya

class ReverseGeocodingService {
    
    let provider = MoyaProvider<NaverReverseGeocodingAPI>()
    
    public func fetchReverseGeocodingData(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let formattedLat = String(format: "%.8f", latitude)
        let formattedLng = String(format: "%.8f", longitude)
        provider.request(.reverseGeocode(latitude: formattedLat, logitude: formattedLng)) { result in
            switch result {
            case .success(let response):
                do {
                    print(response.description)
                    let decodedData = try JSONDecoder().decode(ReverseGeoCodingData.self, from: response.data)
                    if let firstResult = decodedData.results.first {
                        let address = self.makeroadAddress(from: firstResult)
                        completion(address)
                    }
                } catch {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                print("네트워크 에러: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    /// 얻은 도로명 주소 합쳐서 표시하기
    /// - Parameter result: 읽기 쉬운 도로명 주소로 합치기
    private func makeroadAddress(from result: ResultData) -> String {
        let area1 = result.region.area1.name
        let area2 = result.region.area2.name
        let area3 = result.region.area3.name
        let area4 = result.region.area4.name
        
        
        return [area1, area2, area3, area4].joined(separator: " ")
    }
}
