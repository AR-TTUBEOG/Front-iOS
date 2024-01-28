//
//  TtuluttuDotShape.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

/// 뚜닷의 기본 원을 만들고, 그 중심에 회전 각도를 더한다.
struct TtuDotShape: View {
    
    //MARK: - Property
    var sections: [TtuDotSection]
    let action: (Int) -> Void
    var radius: CGFloat
    var center: CGPoint
    
    //MARK: - Body
    var body: some View {
        ZStack{
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
                .contentShape(Path { path in
                    path.move(to: center)
                    path.addArc(center: center, radius: radius, startAngle: Angle(radians: Double(startAngle)), endAngle: Angle(radians: Double(endAngle)), clockwise: false)
                })
                .onTapGesture {
                    self.action(index)
                }
            }
        }
    }
}

