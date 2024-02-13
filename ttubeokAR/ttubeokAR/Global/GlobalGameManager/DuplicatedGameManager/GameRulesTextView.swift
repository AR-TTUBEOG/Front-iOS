//
//  GameRulesView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/7/24.
//

import SwiftUI

struct GameRulesTextView: View {
    
    var label: String
    var onMinusTapped: () -> Void
    var valueLabel: String
    var onPlustTapped: () -> Void
    
    var body: some View {
        makeText()
    }
    
    private func makeText() -> some View {
        HStack(spacing: 35) {
            Text(self.label)
                .font(.sandol(type: .regular, size: 13))
                .frame(width: 58, height: 16, alignment: .center)
                .foregroundStyle(Color.textPink)
            
            HStack(spacing: 2) {
                Button(action: {
                    self.onMinusTapped()
                }, label: {
                    Image(systemName: "minus")
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.white)
                        .background(Color.primary03)
                        .clipShape(Circle())
                })
                
                
                Text(valueLabel)
                    .frame(width: 70, height: 25)
                    .font(.sandol(type: .regular, size: 13))
                    .foregroundStyle(Color.textPink)
                    
                
                
                Button(action: {
                    self.onPlustTapped()
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.white)
                        .background(Color.primary03)
                        .clipShape(Circle())
                })
                
            }
            .frame(width: 130, height: 33)
        }
        .frame(width: 210, height: 33)
    }
}
