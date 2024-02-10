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
                .font(.sandol(type: .regular, size: 12))
                .frame(maxWidth: 58, maxHeight: 16, alignment: .center)
                .foregroundStyle(Color.textPink)
            
            HStack(spacing: 2) {
                Button(action: {
                    self.onMinusTapped()
                }, label: {
                    Image(systemName: "minus")
                        .frame(maxWidth: 25, maxHeight: 25)
                        .foregroundStyle(Color.white)
                        .background(Color.primary03)
                        .clipShape(Circle())
                })
                
                
                Text(valueLabel)
                    .frame(maxWidth: 70, maxHeight: 25)
                    .font(.sandol(type: .regular, size: 12))
                    .foregroundStyle(Color.textPink)
                    
                
                
                Button(action: {
                    self.onPlustTapped()
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: 25, maxHeight: 25)
                        .foregroundStyle(Color.white)
                        .background(Color.primary03)
                        .clipShape(Circle())
                })
                
            }
            .frame(maxWidth: 130, maxHeight: 33)
        }
        .frame(maxWidth: 210, maxHeight: 33)
    }
}
