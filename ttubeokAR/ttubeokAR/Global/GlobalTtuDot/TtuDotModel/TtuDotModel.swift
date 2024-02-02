//
//  TtuluttuDotCommand.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation

protocol TtuDotModel {
    var onExecute: (() -> Void)? { get set }
    func execute()
}

struct TtuDotSection {
    var command: TtuDotModel
    var title: String
    var imageName: String
}

struct TtuDot {
    var sections: [TtuDotSection]
}
