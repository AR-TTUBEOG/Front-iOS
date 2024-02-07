//
//  SearchAPITarget.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/8/24.
//

import Foundation
import Moya

enum SearchAPITarget {
    case searchLatest(page: Int)
    case searchDistance(page: Int)
    case searchRecommend(page: Int)
}
