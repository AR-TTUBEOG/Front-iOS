//
//  View.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/11/24.
//

import Foundation
import SwiftUI

extension View {
    
    func screenSizeBinding(_ screenSize: Binding<CGSize>) -> some View {
            self.modifier(ScreenSizeModifier(screenSize: screenSize))
        }
}
