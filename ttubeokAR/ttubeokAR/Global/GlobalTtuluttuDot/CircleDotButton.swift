//
//  CircleDotButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import SwiftUI

struct CircleDotButton: View {
    @ObservedObject var viewModel = TtuluttuDotViewModel()
    @State private var previousAngle: Angle = .zero
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                TtuluttuDotShape(sections: viewModel.sections)
                    .rotationEffect(.degrees(viewModel.angle))
                
                ForEach(0..<viewModel.sections.count, id: \.self) { index in
                    let sectionsAngle = 360 / CGFloat(viewModel.sections.count)
                    let rotation = sectionsAngle * CGFloat(index) + (sectionsAngle / 2)
                    let textRotation = viewModel.angle + rotation
                    let textAngle = -textRotation
                    let offsetRadius = min(geometry.size.width, geometry.size.height) / 2 * 0.5
                    
                    VStack{
                        Image(viewModel.sectionsImage[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 32)
                        
                        Text(viewModel.sections[index])
                            .foregroundStyle(Color(red: 0.18, green: 0.16, blue: 0.34))
                            .font(.system(size: 11))
                    }
                    .rotationEffect(Angle(degrees: Double(textAngle)))
                    .offset(x:0, y: -offsetRadius)
                    .rotationEffect(Angle(degrees: Double(textRotation)))
                    
                }
                
                Circle()
                    .fill(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.16, green: 0.15, blue: 0.27), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.35, green: 0.28, blue: 0.63), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.45, y: 1.17),
                            endPoint: UnitPoint(x: 0.5, y: 0)
                        )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    .frame(width: 79.72922, height: 79.72922)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .gesture(
                DragGesture()
                    .onChanged{ gesture in
                        let touchPoint = gesture.location
                        let angle = Angle(radians: atan2(touchPoint.y - center.y, touchPoint.x - center.x))
                        
                        if previousAngle != .zero {
                            let angleDifference = angle - previousAngle
                            viewModel.angle += angleDifference.degrees
                        }
                        
                        previousAngle = angle
                    }
                    .onEnded{ _ in
                        previousAngle = .zero
                        
                        guard self.viewModel.sections.count > 0 else { return }
                        
                        let normalizedAngle = (360 - self.viewModel.angle.truncatingRemainder(dividingBy: 360)).truncatingRemainder(dividingBy: 360)
                        let sectionAngle = 360 / Double(self.viewModel.sections.count)
                        let offsetAngle = sectionAngle / 2
                        let selectedIndex = Int(((normalizedAngle + offsetAngle) / sectionAngle).truncatingRemainder(dividingBy: Double(self.viewModel.sections.count)))
                        self.viewModel.selectSection(index: selectedIndex)
                    }
            )
        }
    }
}

#Preview {
    CircleDotButton()
}
