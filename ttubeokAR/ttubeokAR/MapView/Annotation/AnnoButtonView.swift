//
//  AnnotationButtonView.swift
//  ttubeokAR
//
//  Created by Subeen on 2/3/24.
//

import SwiftUI

struct AnnoButtonView: View {
    var type: AnnoType
    @Binding var isSelected: Bool
    

    var body: some View {

            ZStack {
                if isSelected {
                    backgroundView()
                }
                
                Button {
                    isSelected.toggle()
                    
                } label: {
                    switch type {
                    case .cafe :
                        Image(.restaurantMap2)
                    case .restaurant:
                        Image(.restaurantMap2)
                    case .route:
                        Image(.restaurantMap2)
                    }
                    
                }
                .scaleEffect(isSelected ? 1.5 : 1.0, anchor: .init(x: 0.5, y: 0.86))
                .border(Color.gray)
            }
        
    }
    
    private struct backgroundView: View {
        
        let gradient = LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .bottom, endPoint: .center)
        
        fileprivate var body: some View {
            Circle()
                .trim(from: 0.05, to: 0.45)
                .stroke(gradient, style: .init(lineWidth: 45, lineCap: .round))
                .rotationEffect(.degrees(180))
                .offset(y: -25)
                .frame(width: 100, height: 100)
//                .foregroundStyle(gradient)
                .overlay {
                    HStack {
                        Button {
                            print("anno : present")
                        } label: {
                            Image("message")
                        }
                        .offset(x: -15, y: -52)
                        
                        Button {
                            print("anno : coupon")
                        } label: {
                            Image("message")
                        }
                        .offset(y: -74)
                        
                        Button {
                            print("anno : game")
                        } label: {
                            Image("message")
                        }
                        .offset(x: 15, y: -52)
                    }
                    
                }
        }
    }
}

#Preview {
    AnnoButtonView(type: .cafe, isSelected: .constant(true))
}
