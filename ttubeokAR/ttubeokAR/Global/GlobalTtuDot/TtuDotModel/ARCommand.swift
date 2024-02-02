//
//  ARCommand.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation

class ARCommand: TtuDotModel {
    var onExecute: (() -> Void)?
    
    func execute() {
        print("AR버튼입니다!!")
    }
}
