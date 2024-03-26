//
//  BookMarkMakeAPI.swift
//  ttubeokAR
//
//  Created by 정의찬 on 3/25/24.
//

import Foundation
import Moya
import SwiftUI

enum BookMarkAPI {
    case createBookMark(data: BookMarkInputData, token: String)
    case sendBookMarkImage(guestBookId: Int, images: [UIImage], token: String)
}

extension BookMarkAPI: TargetType {
    var baseURL: URL { return URL(string: "http://ttubeog.kro.kr:8080")! }
    
    var path: String {
        switch self {
        case .createBookMark:
            return "/api/v1/guestbook"
        case .sendBookMarkImage:
            return "/api/v1/image/guestbook"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createBookMark:
            return .post
        case .sendBookMarkImage:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createBookMark(let data, _):
            return .requestJSONEncodable(data)
        case .sendBookMarkImage(let id, let images, _):
            var multipartData = [MultipartFormData]()
            
            for(index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    multipartData.append(MultipartFormData(provider: .data(imageData), name: "fileList", fileName: "image\(index).jpg", mimeType: "image/jpg"))
                }
            }
            
            multipartData.append(MultipartFormData(provider: .data("\(id)".data(using: .utf8)!), name: "guestBookId"))
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createBookMark(_, let token):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .sendBookMarkImage(_, _, let token):
            return [
                "Content-type": "multipart/form-data",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
