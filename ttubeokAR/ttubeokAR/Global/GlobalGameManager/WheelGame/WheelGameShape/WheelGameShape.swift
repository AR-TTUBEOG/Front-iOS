//
//  WheelGameShape.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/11/24.
//

import SwiftUI
struct WheelGameShape: Shape {
    // MARK: - Properties
    var startAngle: Angle
    var endAngle: Angle
    var innerRadiusRatio: CGFloat = 0.35
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outRadius = min(rect.width, rect.height) / 2 * 0.88
        let innerRadius = outRadius * innerRadiusRatio
        
        var path = Path()
        
        path.addArc(center: center, radius: outRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        path.closeSubpath()
        
        return path
    }
}
