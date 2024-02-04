//
//  LinearProgressViewStyle.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import SwiftUI

struct LinearProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .scaleEffect(x: 1, y: 2, anchor: .center)
            .frame(maxWidth: 350, maxHeight: 8)
            .background(Color(red: 0.78, green: 0.76, blue: 0.96).opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
            .tint(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.52, green: 0.54, blue: 0.92), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.87, green: 0.83, blue: 0.97), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.32, y: 0.5),
                    endPoint: UnitPoint(x: 1.08, y: 0.5)
                )
            )
    }
}
