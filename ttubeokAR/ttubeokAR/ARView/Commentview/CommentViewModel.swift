//
//  CommentViewModel.swift
//  ttubeokAR
//
//  Created by 최윤아 on 2/9/24.
//

import Foundation
import Moya

class CommentViewModel: ObservableObject{
    // MARK: - Property
    @Published var commentText : String = "" // 댓글 텍스트 임의 데이터
    let provider = MoyaProvider<CommentAPITarget>()

    
    //MARK: - 댓글 남기기(기록하기) 버튼 api 함수
    func fetchCreateComment(content: String, latitude: Double, longitude: Double) {
        provider.request(.CreateComment(content: content, latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try response.mapJSON()  //json 에 데이터 받아오기
                } catch {
                    print("데이터 매핑 실패: \(error)")
                }
            case .failure(let error):
                print("API 호출 실패: \(error)")
            }
        }
    }

}
