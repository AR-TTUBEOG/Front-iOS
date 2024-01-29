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
    @FocusState private var isTextFocused: Bool
    
    
    //MARK: - Shame
    let placeholder: String
    let fontSize: CGFloat
    let cornerSize: CGFloat
    let horizaontalPadding: CGFloat
    let verticalPadding: CGFloat
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    var showSearchIcon: Bool
    var onSearch: () -> Void
    
    //MARK: - Body
    var body: some View {
        inputOneLineTextField
    }
    
    //MARK: - CustomOneLineTextFieldView
    private var inputOneLineTextField: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .font(.sandol(type: .regular, size: fontSize))
                .foregroundStyle(Color.textPink)
                .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .leading)
                .focused($isTextFocused)
                .padding(.leading, horizaontalPadding)
                .background(Color(red: 0.25, green: 0.24, blue: 0.37))
                .clipShape(.rect(cornerRadius: cornerSize))
                .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(Color.primary01, lineWidth: 1)
                )
                inputPlaceholder
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
    
    private var inputPlaceholder: some View {
        ZStack(alignment: .leading){
            if text.isEmpty && !isTextFocused{
                Text(placeholder)
                    .font(.sandol(type: .regular, size: fontSize))
                    .foregroundStyle(Color.textPink)
                    .padding(.leading, horizaontalPadding)
                    .padding(.top, verticalPadding)
                    .allowsHitTesting(false)
            }
            HStack {
                Spacer()
                    .frame(maxWidth: maxWidth - 40)
                if showSearchIcon {
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
                }
            }
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .leading)
    }
    
    
    //MARK: - CustomMoreThanOneLineTextFieldView
    private var inputPlaceDescriptionHolder: some View {
        VStack(alignment: .leading) {
            if text.isEmpty && !isTextFocused{
                Text(placeholder)
                    .font(.sandol(type: .regular, size: fontSize))
                    .foregroundStyle(Color.textPink)
                    .padding(.leading, horizaontalPadding)
                    .padding(.top, verticalPadding)
                    .allowsHitTesting(false)
            }
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: .topLeading)
        .clipShape(.rect(cornerRadius: cornerSize))
    }
}
