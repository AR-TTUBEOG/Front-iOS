//
//  MarketViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import Foundation
import SwiftUI

class MarketViewModel: ObservableObject {
    
    //MARK: - Property
    @Published var currentPageIndext: Int = 1
    
    //MARK: - saveTextInputs
    @Published var firstMarketName: String = ""
    @Published var secondAddressName: String = ""
    @Published var secondDetailAddress: String = ""
    @Published var thirdMarketTypeName: String = ""
}

