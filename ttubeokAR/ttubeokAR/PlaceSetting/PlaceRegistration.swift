//
//  PlaceRegistration.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/26/24.
//

import SwiftUI

//TODO:  NavigationStack 사용하여 뷰 연결할 것!
struct PlaceRegistration: View {
    var body: some View {
        allView
    }
    
    //MARK: - PlaceRegistrationView
    
    /// 뷰 위치 배치하기
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                backgroundView
                blackOpacityView
                title
                    .padding(.top, 94)
                nextButton
                    .position(x: geometry.size.width/2, y: geometry.size.height * 0.9)
            }
        }
    }
    
    /// 배경 화면 설정
    private var backgroundView: some View {
            Icon.PlaceBackground.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 375, maxHeight: .infinity)
                .ignoresSafeArea(.all)
    }
    
    /// 배경 화면 위 검은 배경
    private var blackOpacityView: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.3))
    }
    
    /// 타이틀 작성
    @ViewBuilder
    private var title: some View {
        VStack(alignment: .center, spacing: 30) {
            Text(customAttributedSting())
                .font(.sandol(type: .bold, size: 28))
                .frame(maxWidth: 339, maxHeight: 79)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
            
            Text("장소를 등록하면 경로와 방명록을 \n남길 수 있어요 !")
                .font(.sandol(type: .light, size: 20))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 274, maxHeight: 60)
                .foregroundColor(Color(red: 0.92, green: 0.9, blue: 0.97).opacity(0.8))
        }
    }
    
    /// 다음 뷰로 넘어가는 버튼
    private var nextButton: some View {
        Button(action: {
            print("hello")
        }, label: {
            Text("장소 등록하기")
                .font(.sandol(type: .medium, size: 20))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .frame(maxWidth: 335, maxHeight: 55)
                .background((RoundedRectangle(cornerRadius: 19).fill(Color.primary03)))
        })
    }
    
    //MARK: - Function
    private func customAttributedSting() -> AttributedString {
        var attr = AttributedString("1분만에 장소를 \n 등록해보세요")
        if let range = attr.range(of: "장소") {
            attr[range].font = .sandol(type: .bold, size: 28)
            attr[range].foregroundColor = .primary03
        }
        return attr
    }
}





#Preview {
    PlaceRegistration()
}
