//
//  CustomSlider.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/15/24.
//

import SwiftUI

struct CustomSlider: View {
    
    //MARK: - Property
    
    @Binding var value: Double
    var range: ClosedRange<Double>
    // 슬라이더 배경색 ( 회색계열 )
    private let backgroundFill = Color(red: 0.78, green: 0.76, blue: 0.96).opacity(0.4)
    
    // 슬라디어 핸들러를 통해 움직이며 바뀌는 배경색 ( 그라디언트 )
    private let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.52, green: 0.54, blue: 0.92), location: 0.00),
            Gradient.Stop(color: Color(red: 0.87, green: 0.83, blue: 0.97), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.32, y: 0.5),
        endPoint: UnitPoint(x: 1.08, y: 0.5)
    )
    
    //MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            HStack{
                Spacer(minLength: 15)
                ZStack(alignment: .leading) {
                    backgroundSlider(geometry: geometry)
                    backgroundHandleSlider(geometry: geometry)
                    markZip(geometry: geometry)
                }
                Color.clear.ignoresSafeArea()
            }
        }
        .frame(maxWidth: 400, maxHeight: 10)
    }
    
    //MARK: - Func
    private func markZip(geometry: GeometryProxy) -> some View {
        ZStack {
            markPosition(2.5, label: "3km", geometry: geometry)
            markPosition(5.0, label: "5.5km", geometry: geometry)
            markPosition(7.5, label: "8km", geometry: geometry)
            sliderHandle(geometry: geometry)
        }
    }
    
    private func backgroundSlider(geometry: GeometryProxy) -> some View {
        Rectangle()
            .fill(backgroundFill)
            .frame(width: geometry.size.width * 0.85, height: 17)
            .clipShape(.rect(cornerRadius: 10))
    }
    
    private func backgroundHandleSlider(geometry: GeometryProxy) -> some View {
        let sliderWidth = geometry.size.width * 0.85
        let normalizedValue = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        let backgroundWidth = normalizedValue * sliderWidth + CGFloat(5)
        
        return Rectangle()
            .fill(gradient)
            .frame(width: backgroundWidth, height: 17)
            .clipShape(.rect(cornerRadius: 10))
    }
    
    private func sliderHandle(geometry: GeometryProxy) -> some View {
        let totalSliderWidth = geometry.size.width * 0.85
        let handleWidthHalf = CGFloat(12)
        let sliderWidth = totalSliderWidth
        let normalizedValue = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        let handlePosition = normalizedValue * sliderWidth - handleWidthHalf
        
        return Image("slider")
            .fixedSize()
            .aspectRatio(contentMode: .fit)
            .offset(x: handlePosition, y: 0)
            .gesture(DragGesture(minimumDistance: 0).onChanged { gesture in
                let newSliderPosition = min(max(gesture.location.x, 0), totalSliderWidth)
                let newValue = Double((newSliderPosition) / sliderWidth) * (range.upperBound - range.lowerBound) + range.lowerBound
                self.value = min(max(newValue, range.lowerBound), range.upperBound)
            })
    }
    
    private func markPosition(_ position: Double, label: String, geometry: GeometryProxy) -> some View {
        let totalSliderWidth = geometry.size.width * 0.85
        let normalizedPosition = CGFloat((position - range.lowerBound) / (range.upperBound - range.lowerBound))
        let markPosition = normalizedPosition * totalSliderWidth
        
        return VStack {
            Rectangle()
            .fill(Color.white.opacity(0.5))
            .frame(width: 2, height: 17)
            Text(label)
                .font(.sandol(type: .medium, size: 11))
                .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
        }
        .offset(x: markPosition, y: 9)
    }
}

struct CustomSlider_Preview: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var sliderValue: Double = 5 // Initial value
        
        var body: some View {
            CustomSlider(value: $sliderValue, range: 0...10)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}

