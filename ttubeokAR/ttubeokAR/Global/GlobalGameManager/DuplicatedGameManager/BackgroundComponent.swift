//
//  BasketBallGameView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct BackgroundComponent: View {
    //MARK: - Property
    
    let topTitle: String
    let viewWidth: CGFloat
    let viewHeight: CGFloat
    let secondViewWidth: CGFloat
    let secondViewHeight: CGFloat
    let fontSize: CGFloat
    let cornerSize: CGFloat
    
    init(topTitle: String = "",
         viewWidth: CGFloat = 350,
         viewHeight: CGFloat = 720,
         secondViewWidth: CGFloat = 300,
         secondViewHeight: CGFloat = 660,
         fontSize: CGFloat = 18,
         cornerSize: CGFloat = 24
    ) {
        self.topTitle = topTitle
        self.viewWidth = viewWidth
        self.viewHeight = viewHeight
        self.secondViewWidth = secondViewWidth
        self.secondViewHeight = secondViewHeight
        self.fontSize = fontSize
        self.cornerSize = cornerSize
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            backgroundComponent
            
            VStack(alignment: .center, spacing: 12) {
                topTitleComponent
                secondBackgroundComponent
            }
            .frame(maxWidth: secondViewWidth, maxHeight: secondViewHeight)
        }
        .frame(maxWidth: viewWidth, maxHeight: viewHeight)
        .padding(.all, 10)
    }
    
    //MARK: - BasketBallGameView
    
    private var topTitleComponent: some View {
        Text(topTitle)
            .font(.sandol(type: .semiBold, size: fontSize))
            .foregroundStyle(Color.white)
            .frame(maxWidth: 86, maxHeight: 22)
    }
    
    private var backgroundComponent: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color(red: 0.44, green: 0.40, blue: 0.89),
                            Color(red: 0.44, green: 0.40, blue: 0.89),
                            Color(red: 0.63, green: 0.62, blue: 0.95)]),
                    
                    startPoint: .top, endPoint: .bottom)
            )
            .clipShape(.rect(cornerRadius:  cornerSize))
    }
    
    private var secondBackgroundComponent: some View {
        Rectangle()
            .fill(Color(red: 0.25, green: 0.24, blue: 0.37))
            .clipShape(.rect(cornerRadius: cornerSize))
    }
}

#Preview {
    BackgroundComponent(topTitle: "농구게임")
        .previewLayout(.sizeThatFits)
}
