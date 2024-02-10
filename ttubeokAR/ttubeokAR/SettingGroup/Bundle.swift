//
//  Bundle.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/9/24.
//

import Foundation


extension Bundle {
    var nmfClientId: String {
        return object(forInfoDictionaryKey: "NMFClientId") as? String ?? "x"
    }

    var nmfClientSecret: String {
        return object(forInfoDictionaryKey: "NMFClientSecret") as? String ?? "x"
    }
}
