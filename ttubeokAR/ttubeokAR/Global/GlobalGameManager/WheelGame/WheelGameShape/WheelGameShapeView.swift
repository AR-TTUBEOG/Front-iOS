//
//  WheelGameShapeView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/11/24.
//

import SwiftUI

struct WheelGameShapeView: View {
    @ObservedObject var viewModel: WheelGameViewModel
    @State private var spin: Double = 0
    @State private var isSpinning = false
    @State private var selectedValue: String?
    
    let wheelSize: CGFloat
    let fontSize: CGFloat
    let arrowSize: CGFloat
    
    init(viewModel: WheelGameViewModel = WheelGameViewModel(),
         wheelSize: CGFloat = 260,
         fontSize: CGFloat = 16,
         arrowSize: CGFloat = 40
    ) {
        self.viewModel = viewModel
        self.wheelSize = wheelSize
        self.fontSize = fontSize
        self.arrowSize = arrowSize
    }
   
    
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                donutShape(geometry)
                wheelGamaCircle(geometry: geometry)
                startButton(geometry)
            }
            .frame(maxWidth: wheelSize, maxHeight: wheelSize)
            
            Icon.wheelArrow.image
                .resizable()
                .frame(maxWidth: arrowSize, maxHeight: arrowSize)
                .aspectRatio(contentMode: .fit)
        }
        
    }
    
    private func wheelGamaCircle(geometry: GeometryProxy) -> some View {
        ZStack {
            ForEach(0..<viewModel.wheelGameSetting.count, id: \.self) { index in
                
                let setting = viewModel.wheelGameSetting[index]
                let text = setting == .goods ? (viewModel.texts.indices.contains(index) ? viewModel.texts[index] : "") : "꽝"
                let count = viewModel.wheelGameSetting.count
                let startAngle = Angle.degrees(Double(index) / Double(count) * 360)
                let endAngle = Angle.degrees(Double(index + 1) / Double(count) * 360)
                let middleAngle = Angle.degrees((startAngle.degrees + endAngle.degrees) / 2)
                
                
                WheelGameShape(startAngle: .degrees(Double(index) / Double(count) * 360), endAngle: .degrees(Double(index + 1) / Double(count) * 360))
                
                    .fill(setting == .goods ? Color.white : Color(red: 0.93, green: 0.94, blue: 0.95))
                
                    .overlay(
                        WheelGameShape(startAngle: .degrees(Double(index) / Double(count) * 360), endAngle: .degrees(Double(index + 1) / Double(count) * 360))
                            .stroke(Color(red: 0.72, green: 0.72, blue: 0.81), lineWidth: 1)
                    )
                
                    wheelSectionText(text, middleAngle, geometry)
            }
        }
        .rotationEffect(.degrees(spin))
    }
    
    private func wheelSectionText(_ text: String, _ angle: Angle, _ geomtery: GeometryProxy) -> some View {
        Text(text)
            .font(.sandol(type: .medium, size: fontSize))
            .foregroundStyle(Color.black)
            .rotationEffect(-angle)
            .rotationEffect(.degrees(spin), anchor: .center)
            .position(
                x: calculateTextPosition(angle: angle, geometry: geomtery).x,
                y: calculateTextPosition(angle: angle, geometry: geomtery).y
            )
    }
    
    private func startButton(_ geometry: GeometryProxy) -> some View {
        Button(action: {
            if !isSpinning {
                isSpinning.toggle()
                spinWheel()
            }
        }, label: {
            
            ZStack(alignment: .center) {
                Circle()
                    .fill(Color.primary03)
                Text("START")
                    .font(.sandol(type: .medium, size: 14))
                    .foregroundStyle(Color.white)
            }
        })
        .frame(maxWidth: geometry.size.width * 0.28, maxHeight: geometry.size.height * 0.28)
        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
    
    private func donutShape(_ geometry: GeometryProxy) -> some View {
        let radiusDiameter = max(geometry.size.width, geometry.size.height) * 2
        
        return Circle()
            .stroke(lineWidth: 20)
            .fill(Color.primary03)
            .frame(maxWidth: radiusDiameter, maxHeight: radiusDiameter)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
    
    private func spinWheel() {
        let randomSpin = Double.random(in: 1600...2400)
        withAnimation(.spring(response: 4, dampingFraction: 0.5)) {
            spin += randomSpin
        } completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isSpinning = false
                finishSection()
            }
        }
    }
    
    private func finishSection() {
        let finalAngle = spin.truncatingRemainder(dividingBy: 360)
        let totalSection = viewModel.wheelGameSetting.count
        let sectionAngle = 360.0 / Double(totalSection)
        let offsetAngle = (finalAngle + sectionAngle * 2).truncatingRemainder(dividingBy: 360)
        let selectedIndex = Int(offsetAngle / sectionAngle) % totalSection
        selectedValue = getValueForSection(selectedIndex)
        print(selectedValue ?? "x")
        print(selectedIndex)
    }
    
    private func getValueForSection(_ index: Int) -> String {
        let setting = viewModel.wheelGameSetting[index]
        return setting == .goods ? (viewModel.texts.indices.contains(index) ? viewModel.texts[index] : "꽝") : "꽝"
    }
    
    private func calculateTextPosition(angle: Angle, geometry: GeometryProxy) -> CGPoint {
        let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.6
        let x = geometry.size.width / 2 + radius * cos(CGFloat(angle.radians))
        let y = geometry.size.height / 2 + radius * sin(CGFloat(angle.radians))
        return CGPoint(x: x, y: y)
    }
}



#Preview {
    WheelGameShapeView(viewModel: WheelGameViewModel.share)
        .previewLayout(.sizeThatFits)
}
