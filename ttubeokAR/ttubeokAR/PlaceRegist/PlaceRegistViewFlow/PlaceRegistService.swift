//
//  WalwayRegistAPI.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import Foundation
import Moya
import SwiftUI

enum PlaceRegistService {
    case sendWalwayInfo(RequestWalwayRegistModel, token: String)
    case sendStoreInfo(RequestMarketRegistModel, token: String)
    case sendWalkwayImage(spotId: Int, token: String, images: [UIImage])
    case sendStoreImage(storeId: Int, token: String, images: [UIImage])
}

extension PlaceRegistService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://ttubeog.kro.kr:8080")!
    }
    
    var path: String {
        switch self {
        case .sendWalwayInfo:
            return "/api/v1/spot"
        case .sendStoreInfo:
            return "/api/v1/store"
        case .sendWalkwayImage:
            return "/api/v1/image/spot"
        case .sendStoreImage:
            return "/api/v1/image/store"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendWalwayInfo:
            return .post
        case .sendStoreInfo:
            return .post
        case .sendWalkwayImage:
            return .post
        case .sendStoreImage:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendWalwayInfo(let parameters, _):
            return .requestJSONEncodable(parameters)
        case .sendStoreInfo(let parameters, _):
            return .requestJSONEncodable(parameters)
        case .sendWalkwayImage(let spotId, _, let images):
            var multipartData = [MultipartFormData]()
            
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    multipartData.append(MultipartFormData(provider: .data(imageData),name: "fileList", fileName: "image\(index).jpg", mimeType: "image/jpg"))
                }
            }
            
            multipartData.append(MultipartFormData(provider: .data("\(spotId)".data(using: .utf8)!), name: "spotId"))
            
            return .uploadMultipart(multipartData)
            
        case .sendStoreImage(let storeId, _, let images):
            var multipartData = [MultipartFormData]()
            
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    multipartData.append(MultipartFormData(provider: .data(imageData),name: "fileList", fileName: "image\(index).jpg", mimeType: "image/jpg"))
                }
            }
            
            multipartData.append(MultipartFormData(provider: .data("\(storeId)".data(using: .utf8)!), name: "storeId"))
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendWalwayInfo(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .sendStoreInfo(_, let token):
            return [
                "Content-type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .sendWalkwayImage(_, let token, _):
            return [
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer \(token)"
            ]
        case .sendStoreImage(_, let token, _):
            return [
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
