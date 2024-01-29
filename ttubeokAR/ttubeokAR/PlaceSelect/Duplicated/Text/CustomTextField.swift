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
    
    
    //MARK: - Shame
    let placeholder: String
    let cornerSize: CGFloat
    let horizaontalPadding: CGFloat
    let verticalPadding: CGFloat
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    var showSearchIcon: Bool
    var onSearch: () -> Void
    
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
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                .padding(.leading, text.isEmpty ? 0 : horizaontalPadding)
                .background(Color(red: 0.25, green: 0.24, blue: 0.37))
                .clipShape(.rect(cornerRadius: cornerSize))
                .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(Color.primary01, lineWidth: 1)
                )
            HStack(){
                if text.isEmpty {
                    Text(placeholder)
                        .font(.sandol(type: .regular, size: 20))
                        .foregroundStyle(Color.textPink)
                        .padding(.leading, horizaontalPadding)
                        .padding(.top, verticalPadding)
                }
                
                if showSearchIcon {
                    Spacer()
                        .frame(maxWidth: 55)
                    Button(action: {
                        onSearch()
                    }, label: {
                        Icon.search.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 20, maxHeight: 27)
                            .foregroundStyle(Color.textPink)
                            .padding(3)
                    })
                    Spacer()
                        .frame(maxWidth: 5)
                }
                else {
                    Spacer()
                }
            }
            .frame(maxWidth: maxWidth, maxHeight: maxHeight - 30, alignment: .leading)
        }
    }
}
