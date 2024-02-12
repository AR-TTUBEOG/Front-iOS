//
//  BasketBallGameView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct BackgroundComponent: View {
    //MARK: - Property
    
    let gradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(red: 0.44, green: 0.40, blue: 0.89),
                Color(red: 0.44, green: 0.40, blue: 0.89),
                Color(red: 0.63, green: 0.62, blue: 0.95)
            ]
        ),
        startPoint: .top, endPoint: .bottom
    )
    
    
    let topTitle: String
    let fontSize: CGFloat
    
    init(topTitle: String = "",
         fontSize: CGFloat = 18
    ) {
        self.topTitle = topTitle
        self.fontSize = fontSize
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            topTitleComponent
            Spacer()
        }
        .frame(maxWidth: 330, maxHeight: 660)
        .background(gradient)
    }
    
    
    //MARK: - BasketBallGameView
    
    private var topTitleComponent: some View {
        Text(topTitle)
            .font(.sandol(type: .semiBold, size: fontSize))
            .foregroundStyle(Color.white)
            .frame(maxWidth: 86, maxHeight: 22)
            .padding(.top, 15)
    }
}

#Preview {
    BackgroundComponent(topTitle: "농구게임")
        .previewLayout(.sizeThatFits)
}
