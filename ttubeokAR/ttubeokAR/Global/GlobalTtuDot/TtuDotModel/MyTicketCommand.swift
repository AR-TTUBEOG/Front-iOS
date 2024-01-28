//
//  MyTicket.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation

class MyTicketCommand: TtuDotModel {
    var onExecute: (() -> Void)?
    
    func execute() {
        print("티켓 보관함 버튼입니다")
    }
}
