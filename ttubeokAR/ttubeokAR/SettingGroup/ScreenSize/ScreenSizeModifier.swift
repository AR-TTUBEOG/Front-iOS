//
//  ScreenSizeModifier.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/11/24.
//

import Foundation
import SwiftUI

struct ScreenSizeModifier: ViewModifier {
    @Binding var screenSize: CGSize
    
    func body(content: Content) -> some View {
        content
            .onAppear{
                guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                
                let screen = window.screen.bounds
                screenSize = screen.size
            }
    }
}
