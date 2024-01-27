//
//  marketSelect.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct WalkSelectButton: View {
    
    //MARK: - Property
    private let frameSize: CGFloat = 157
    private let iconSize: CGFloat = 94
    private let cornerSize: CGFloat = 19
    @Binding var isChecked: Bool
    
    //MARK: - Body
    var body: some View {
        walkIconGroup
    }
    
    //MARK: - WalkSelectButtonView
    private var walkIconGroup: some View {
        ZStack(alignment: .center) {
            walkIconBackground
            Button(action: {
                isChecked.toggle()
            }) {
                walkIcon
                    .offset(y: isChecked ? -10 : 0)
            }
            .animation(.easeOut(duration: 0.5), value: isChecked)
        }
        .frame(maxWidth: frameSize, maxHeight: frameSize)
        .clipShape(.rect(cornerRadius: cornerSize))
    }
    
    private var walkIconBackground: some View {
        ZStack(alignment: .bottomLeading){
            Icon.walkGroup.image
                .resizable()
                .frame(maxWidth: frameSize, maxHeight: frameSize)
                .offset(x: -2, y: 20)
            RoundedRectangle(cornerRadius: cornerSize)
                .foregroundStyle(.clear)
                .frame(maxWidth: frameSize, maxHeight: frameSize)
                .background(Color.white.opacity(0.5))
            Rectangle()
                .foregroundStyle(.clear)
                .frame(minWidth: frameSize, maxWidth: frameSize)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.92, green: 1, blue: 0.58).opacity(0.5), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.14, green: 1, blue: 0).opacity(0.5), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.08, y: 0.03),
                        endPoint: UnitPoint(x: 1, y: 1)
                    )
                )
                .clipShape(.rect(cornerRadius: cornerSize))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.68, green: 1, blue: 0.66), lineWidth: 1)
                )
        }
        .frame(maxWidth: frameSize, maxHeight: frameSize)
    }
    
    private var walkIcon: some View {
        ZStack(alignment: .center){
            Rectangle()
                .foregroundStyle(.clear)
                .frame(maxWidth: frameSize, maxHeight: frameSize)
                .background(Color(red: 0.95, green: 1, blue: 0.77).opacity(0.32))
            
                .clipShape(.rect(cornerRadius: cornerSize))
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.33, green: 1, blue: 0.27).opacity(0.2), lineWidth: 1)
                    
                )
                .blur(radius: 100)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: frameSize, height: frameSize)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.98, green: 1, blue: 0.91).opacity(0.1), location: 0.00),
                            Gradient.Stop(color: .white.opacity(0.1), location: 0.49),
                            Gradient.Stop(color: .white.opacity(0), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 1, y: 0),
                        endPoint: UnitPoint(x: 0.05, y: 1)
                    )
                )
                .clipShape(.rect(cornerRadius: cornerSize))
            Icon.walkIcon.image
                .resizable()
                .frame(maxWidth: iconSize, maxHeight: iconSize)
        }
        .frame(maxWidth: frameSize, maxHeight: frameSize)
    }
}

