//
//  CircleDotButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import SwiftUI

struct TtuDotButton: View {
    @ObservedObject var viewModel = TtuDotViewModel()
    @State private var previousAngle: Angle = .zero
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            ZStack {
                TtuDotShape(sections: viewModel.sections) { index in
                    viewModel.selectSection(at: index)
                }
                .rotationEffect(.degrees(viewModel.angle))
                
                ForEach(viewModel.sections.indices, id: \.self) { index in
                    let section = viewModel.sections[index]
                    let sectionsAngle = 360 / CGFloat(viewModel.sections.count)
                    let rotation = sectionsAngle * CGFloat(index) + (sectionsAngle / 2)
                    let textRotation = viewModel.angle + rotation
                    let textAngle = -textRotation
                    let offsetRadius = min(geometry.size.width, geometry.size.height) / 2 * 0.45
                    
                    VStack{
                        Image(section.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 32)
                        
                        Text(section.title)
                            .foregroundStyle(Color(red: 0.18, green: 0.16, blue: 0.34))
                            .font(.system(size: 11))
                    }
                    .rotationEffect(Angle(degrees: Double(textAngle)))
                    .offset(x:0, y: -offsetRadius)
                    .rotationEffect(Angle(degrees: Double(textRotation)))
//                    .onTapGesture {
//                        viewModel.selectSection(at: index)
//                    }
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
            )
        }
    }
}

#Preview {
    TtuDotButton()
}
