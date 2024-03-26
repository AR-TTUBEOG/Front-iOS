//
//  ViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/8/24.
//

import Foundation
import SwiftUI
import UIKit
import Moya

class BookMarkViewModel: ObservableObject, BookMarkImgProtocol {
    
    // MARK: - Property
    @Published var bookMarkimages: [UIImage]? = nil //임시 방명록 이미지 값
    @Published var contentText: String = "" //임시 방명록 텍스트 필드 값
    @Published var filledStarCount: Int = 0 // 별점 넘기기
    var isImagePickerPresented: Bool = false
    
    // MARK: - API
    
    private let authPlugin: AuthPlugin
    private let bookMarkProvider: MoyaProvider<BookMarkAPI>
    
    init()  {
        self.authPlugin = AuthPlugin(provider: MoyaProvider<MultiTarget>())
        self.bookMarkProvider = MoyaProvider<BookMarkAPI>(plugins: [authPlugin])
    }
    
    // MARK: - Function
    func setImage(_ image: UIImage) {
        self.bookMarkimages?.append(image)
        print("방명록에 추가된 이미지 수 : \(self.bookMarkimages?.count ?? 0)")
    }
    
    func showImagePicker() {
        isImagePickerPresented = true
    }
    
    // MARK: - 방명록 남기기(기록하기) 버튼 api Post 함수
    
//    func createBookMark(id: Int, memberId: Int, content: String, star: Float, image: String) {
//        bookMarkProvider.request(.createBookMark(id: id, memberId: memberId, content: content, star: star, image: image)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let data = try response.mapJSON()
//                    print("API 호출 성공: \(data)")
//                } catch {
//                    print("데이터 매핑 실패: \(error)")
//                }
//            case .failure(let error):
//                print("API 호출 실패: \(error)")
//            }
//        }
//    }
}
