//
//  InputAddressProtocol.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/9/24.
//

import Foundation

protocol InputAddressProtocol: ObservableObject {
    var address: String { get set }
    var detailAddress: String { get set }
    func searchAddress()
}
