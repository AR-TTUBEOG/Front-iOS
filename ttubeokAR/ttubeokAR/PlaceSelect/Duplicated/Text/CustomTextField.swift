//
//  CustomTextField.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/29/24.
//

import SwiftUI

struct CustomTextField: View {
    
    //MARK: - Property
    @Binding var text: String
    let placeholder: String
    let cornerSize: CGFloat
    let horizaontalPadding: CGFloat
    let verticalPadding: CGFloat
    
    //MARK: - Body
    var body: some View {
        inputTextField
    }
    
    //MARK: - CustomTextFieldView
    private var inputTextField: some View {
        ZStack(alignment: .leading) {
            
            TextField("", text: $text)
                .font(.sandol(type: .regular, size: 20))
                .foregroundStyle(Color.textPink)
                .padding(.leading, text.isEmpty ? 0 : horizaontalPadding)
                .frame(maxWidth: 340, maxHeight: 45)
                .background(Color(red: 0.25, green: 0.24, blue: 0.37))
                .clipShape(.rect(cornerRadius: cornerSize))
                .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(Color.primary01, lineWidth: 1)
                )
            
            if text.isEmpty {
                Text(placeholder)
                    .font(.sandol(type: .regular, size: 20))
                    .foregroundStyle(Color.textPink)
                    .padding(.leading, horizaontalPadding)
                    .padding(.top, verticalPadding)
            }
        }
    }
}
