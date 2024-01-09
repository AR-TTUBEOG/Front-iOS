//
//  TtuluttuDotShape.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

struct TtuDotShape: View {
    var sections: [TtuDotSection]
    let action: (Int) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.7
            
            ZStack{
                
                ForEach(0..<sections.count, id: \.self) { index in
                    let sectionAngle = 2 * Double.pi / CGFloat(sections.count)
                    let startAngle = sectionAngle * CGFloat(index) - Double.pi / 2
                    let endAngle = startAngle + sectionAngle
                    
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: Angle(radians: Double(startAngle)), endAngle: Angle(radians: Double(endAngle)), clockwise: false)
                        path.addLine(to: center)
                    }
                    .fill(Color.clear)
                }
                
                Circle()
                    .strokeBorder(Color.clear, lineWidth: radius)
                    .fill(
                        EllipticalGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.75, green: 0.75, blue: 0.95), location: 0.10),
                                Gradient.Stop(color: Color(red: 0.9, green: 0.89, blue: 0.98), location: 0.38),
                                Gradient.Stop(color: .white, location: 1.00),
                            ],
                            center: UnitPoint(x: 0.5, y: 0.5)
                        )
                    )
                    .frame(width: radius * 2, height: radius * 2)
                    .position(center)
            }
        }
    }
}
