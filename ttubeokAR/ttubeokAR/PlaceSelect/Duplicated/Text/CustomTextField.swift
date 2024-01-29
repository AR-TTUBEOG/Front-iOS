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
    
    
    //MARK: - inputProperty
    let placeholder: String
    let fontSize: CGFloat
    let cornerSize: CGFloat
    let horizontalPadding: CGFloat
    let trailingHorizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    var showSearchIcon: Bool
    var onSearch: () -> Void
    var alignment: Alignment
    var axis: Axis
    var maxLength: Int?
    //MARK: - init
    
    init(text: Binding<String>,
         isTextFocused: Bool = false,
         placeholder: String,
         fontSize: CGFloat,
         cornerSize: CGFloat,
         horizontalPadding: CGFloat,
         trailingHorizontalPadding: CGFloat,
         verticalPadding: CGFloat,
         maxWidth: CGFloat,
         maxHeight: CGFloat,
         showSearchIcon: Bool,
         onSearch: @escaping () -> Void,
         alignment: Alignment = .leading,
         axis: Axis = .horizontal,
         maxLength: Int? = nil
        ) {
            self._text = text
            self.placeholder = placeholder
            self.fontSize = fontSize
            self.cornerSize = cornerSize
            self.horizontalPadding = horizontalPadding
            self.trailingHorizontalPadding = trailingHorizontalPadding
            self.verticalPadding = verticalPadding
            self.maxWidth = maxWidth
            self.maxHeight = maxHeight
            self.showSearchIcon = showSearchIcon
            self.onSearch = onSearch
            self.alignment = alignment
            self.axis = axis
            self.maxLength = maxLength
    }
    
    //MARK: - Body
    var body: some View {
        inputOneLineTextField
    }
    
    //MARK: - CustomOneLineTextFieldView
    /// 텍스트 필드 생성
    private var inputOneLineTextField: some View {
        ZStack(alignment: alignment) {
            TextField("", text: $text, axis: axis)
                .font(.sandol(type: .regular, size: fontSize))
                .foregroundStyle(Color.textPink)
                .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: alignment)
                .focused($isTextFocused)
                .padding(.leading, horizontalPadding)
                .padding(.trailing, trailingHorizontalPadding)
                .padding([.top, .bottom], verticalPadding)
                .background(Color(red: 0.25, green: 0.24, blue: 0.37))
                .clipShape(.rect(cornerRadius: cornerSize))
                .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(Color.primary01, lineWidth: 1)
                )
                .onChange(of: text) { oldText, newText in
                    if let maxLength = maxLength, newText.count > maxLength {
                        text = String(newText.prefix(maxLength))
                    }
                }
            inputTextFieldPlaceholder
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
    
    /// 텍스트 필드 내 Plceholder 생성
    private var inputTextFieldPlaceholder: some View {
        ZStack(alignment: alignment) {
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .font(.sandol(type: .regular, size: fontSize))
                    .foregroundStyle(Color.textPink)
                    .padding(.leading, horizontalPadding)
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
        .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: alignment)
    }
}
