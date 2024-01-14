//
//  SliderLine.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/15/24.
//

import Foundation
import SwiftUI

struct SliderLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
