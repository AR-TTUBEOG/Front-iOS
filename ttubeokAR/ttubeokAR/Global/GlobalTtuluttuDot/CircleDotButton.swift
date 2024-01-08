//
//  CircleDotButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import SwiftUI

struct CircleDotButton: View {
    @ObservedObject var viewModel = TtuluttuDotViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                TtuluttuDotShape(sections: viewModel.sections)
                    .rotationEffect(.degrees(viewModel.angle))
                
                ForEach(0..<viewModel.sections.count, id: \.self) { index in
                    let sectionAngle = 360 / CGFloat(viewModel.sections.count)
                    let rotation = sectionAngle * CGFloat(index) + (sectionAngle / 2)
                    let textRotation = viewModel.angle + rotation
                    let textAngle = -textRotation
                    let offsetRadius = min(geometry.size.width, geometry.size.height) / 2 * 0.5
                    
                    Text(viewModel.sections[index])
                        .foregroundStyle(Color.black)
                        .rotationEffect(Angle(degrees: Double(textAngle)))
                        .offset(x: 0, y: -offsetRadius)
                        .rotationEffect(Angle(degrees: Double(textRotation)))
                        .font(.system(size: 16).bold())
                }
            }
            .gesture(
                DragGesture()
                    .onChanged{ gesture in
                        let scalingFactor: CGFloat = 0.1
                        let dragAngle = (gesture.translation.height / geometry.size.height * 360) * scalingFactor
                        self.viewModel.angle -= dragAngle
                        print(dragAngle)
                    }
                    .onEnded{ _ in
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
