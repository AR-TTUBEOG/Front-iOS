//
//  CircleDotButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//
//let radius = min(screenSize.width, screenSize.height) / 2 * 0.7


import SwiftUI

/// 여러 버튼의 기능을 하나의 버튼에 두어 여러 기능을 제공하는 버튼이다.
struct TtuDotButton: View {
    
    //MARK: - Property
    var sharedTabInfo: SharedTabInfo
    @ObservedObject var viewModel: TtuDotViewModel
    @State private var previousAngle: Angle = .zero
    @State private var rotationVelocity: Double = 0
    
    /// viewModel과 sharedTabInfo 초기화
    /// - Parameter sharedTabInfo: 선택된 탭 번호 앱 사이클에 공유하기 위한 클래스
    init(sharedTabInfo : SharedTabInfo) {
        self.sharedTabInfo = sharedTabInfo
        self.viewModel = TtuDotViewModel(sharedTabInfo: self.sharedTabInfo)
    }
    
    //MARK: - Body
    var body: some View {
            ZStack{
                GeometryReader { geometry in
                    let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height * ( 1 - 0.075))
                    let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.7
                    
                    ZStack {
                        createTtuDotShape(geometry: geometry, radius: radius, center: center)
                        createCenterCircle(geometry: geometry)
                        createSectionViews(gemetry: geometry)
                    }
                    .gesture(createDragGesture(center: center))
                    
                }
            }
            .onChange(of: viewModel.angle) { oldValue, newValue in
                let angleDiff = newValue - oldValue
                rotationVelocity = angleDiff
            }
    }
    
    //MARK: - TtuDotButton View
    
    /// 뚜닷의 기본이 되는 원을 생성한다.
    /// - Parameters:
    ///   - geometry: 화면의 사이즈에 맞추어 동일한 비율의 원을 생성한다.
    ///   - radius: 화면의 값에 맞추어 정해진 반지름을 기준으로 뚜닷의 원을 그린다.
    ///   - center: 뚜닷의 원을 그리고자 하는 중간 center자리를 넘긴다.
    /// - Returns: 뷰로써 리턴한다.
    private func createTtuDotShape(geometry: GeometryProxy, radius: CGFloat, center: CGPoint) -> some View {
        TtuDotShape(sections: viewModel.sections, action: { index in
            viewModel.selectSection(at: index)
        }, radius: radius , center: center)
        .rotationEffect(.degrees(viewModel.angle), anchor: .init(x: center.x / geometry.size.width, y: center.y / geometry.size.height))
    }
    
    /// 원위에 그림과 글자를 원에 맞추어 생성하여 회전하면서 사용할 수 있도록 하낟.
    /// - Parameter gemetry: 화면의 사이즈에 맞추어 동일한 비율의 원을 생성한다
    /// - Returns: 뷰로써 리턴한다.
    private func createSectionViews(gemetry: GeometryProxy) -> some View {
        ForEach(viewModel.sections.indices, id: \.self) { index in
            let section = viewModel.sections[index]
            let sectionsAngle = 360 / CGFloat(viewModel.sections.count)
            let rotation = sectionsAngle * CGFloat(index) + (sectionsAngle / 2)
            let textRotation = viewModel.angle + rotation
            let textAngle = -textRotation
            let offsetRadius = min(gemetry.size.width, gemetry.size.height) / 2 * 0.45
            
            VStack{
                Image(section.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 32)
                
                Text(section.title)
                    .foregroundStyle(Color(red: 0.18, green: 0.16, blue: 0.34))
                    .font(.sandol(type: .light, size: 11))
            }
            .position(x: gemetry.size.width / 2, y : gemetry.size.height * ( 1 - 0.075))
            .rotationEffect(Angle(degrees: Double(textAngle)))
            .offset(x:0, y: -offsetRadius)
            .rotationEffect(Angle(degrees: Double(textRotation)))
            .onTapGesture {
                viewModel.selectSection(at: index)
            }
        }
    }
    
    /// 뚜닷의 회전 중심축에 원을 두어 디자인
    /// - Parameter geometry: 화면의 사이즈에 맞추어 일정한 비율에 생성되도록 함.
    /// - Returns: 뷰로써 값 돌려준다.
    private func createCenterCircle(geometry: GeometryProxy) -> some View {
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
            .frame(width: 60, height: 60)
            .position(x: geometry.size.width / 2, y: geometry.size.height * ( 1 - 0.075))
    }
    
    /// 회전을 돌리면 돌릴 때의 값을 측정에 터치를 뗀 후에 원이 돌아가도록 유지한다.
    /// - Parameter center: 원의 center값을 기준으로 돌아가도록 한다.
    /// - Returns: 제스쳐값으로 리턴한다.
    private func createDragGesture(center: CGPoint) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                let touchPoint = gesture.location
                let angle = Angle(radians: atan2(touchPoint.y - center.y, touchPoint.x - center.x))
                
                if previousAngle != .zero {
                    let angleDifference = angle - previousAngle
                    viewModel.angle += angleDifference.degrees
                }
                
                previousAngle = angle
            }
            .onEnded{ _ in
                withAnimation(.easeOut(duration: 0.6)) {
                    viewModel.angle += rotationVelocity * 20
                    rotationVelocity = 0
                }
                previousAngle = .zero
            }
    }
}
