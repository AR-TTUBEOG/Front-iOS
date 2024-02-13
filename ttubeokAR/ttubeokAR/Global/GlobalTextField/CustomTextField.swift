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
    let leadingHorizontalPadding: CGFloat
    let trailingHorizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    var showSearchIcon: Bool
    var onSearch: () -> Void
    var alignment: Alignment
    var axis: Axis
    var maxLength: Int?
    var backgroundColor: Color
    var fontColor: Color
    var lineWidth: CGFloat
    var lineColor: Color
    //MARK: - init
    
    /// 커스텀 텍스트 필드 init 값 지정
    /// - Parameters:
    ///   - text: 입력하는 텍스트 값 실시간 저장
    ///   - isTextFocused:텍스트 필드 클릭시 placeholder 값 삭제 되도록 하기 위함
    ///   - placeholder: placeholder 텍스트 값 지정
    ///   - fontSize: 기본 값 20 사용
    ///   - cornerSize: 기본값 19 사용
    ///   - leadingHorizontalPadding: leading padding 값
    ///   - trailingHorizontalPadding: trailing padding 값 지정
    ///   - verticalPadding: verical padding 값 지정
    ///   - maxWidth: 커스텀 텍스트 필드 width 값
    ///   - maxHeight: 커스텀 텍스트 필드 height 값
    ///   - showSearchIcon: 돋보기 아이콘 보기 위한 Bool 값 지정
    ///   - onSearch: 텍스트 필드가 수행해야 할 function 지정
    ///   - alignment:스택 및 frame 정렬 값
    ///   - axis: 텍스트 필드의 자동 줄 생성 축 지정
    ///   - maxLength: 텍스트 필드의 최대 글자 수 지정
    init(text: Binding<String>,
         isTextFocused: Bool = false,
         placeholder: String,
         fontSize: CGFloat = 20,
         cornerSize: CGFloat = 19,
         leadingHorizontalPadding: CGFloat = 15,
         trailingHorizontalPadding: CGFloat = 15,
         verticalPadding: CGFloat = 5,
         maxWidth: CGFloat,
         maxHeight: CGFloat,
         showSearchIcon: Bool = false,
         onSearch: @escaping () -> Void,
         alignment: Alignment = .leading,
         axis: Axis = .horizontal,
         maxLength: Int? = nil,
         backgroundColor: Color = Color(red: 0.25, green: 0.24, blue: 0.37),
         fontColor: Color = Color.textPink,
         lineWidth: CGFloat = 1,
         lineColor: Color = Color.primary01
        ) {
            self._text = text
            self.placeholder = placeholder
            self.fontSize = fontSize
            self.cornerSize = cornerSize
            self.leadingHorizontalPadding = leadingHorizontalPadding
            self.trailingHorizontalPadding = trailingHorizontalPadding
            self.verticalPadding = verticalPadding
            self.maxWidth = maxWidth
            self.maxHeight = maxHeight
            self.showSearchIcon = showSearchIcon
            self.onSearch = onSearch
            self.alignment = alignment
            self.axis = axis
            self.maxLength = maxLength
            self.backgroundColor = backgroundColor
            self.fontColor = fontColor
            self.lineWidth = lineWidth
            self.lineColor = lineColor
    }
    
    //MARK: - Body
    var body: some View {
        inputOneLineTextField
            .onTapGesture {
                isTextFocused = false
            }
    }
    
    //MARK: - CustomOneLineTextFieldView
    /// 텍스트 필드 생성
    private var inputOneLineTextField: some View {
        ZStack(alignment: alignment) {
            TextField("", text: $text, axis: axis)
                .frame(width: maxWidth, height: maxHeight, alignment: alignment)
                .font(.sandol(type: .regular, size: fontSize))
                .foregroundStyle(fontColor)
                .focused($isTextFocused)
                .padding(.leading, leadingHorizontalPadding)
                .padding(.trailing, trailingHorizontalPadding)
                .padding([.top, .bottom], verticalPadding)
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: cornerSize))
                .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerSize)
                        .inset(by: 0.5)
                        .stroke(lineColor, lineWidth: lineWidth)
                )
                .onChange(of: text) { oldText, newText in
                    if let maxLength = maxLength, newText.count > maxLength {
                        text = String(newText.prefix(maxLength))
                    }
                }
            inputTextFieldPlaceholder
        }
    }
    
    /// 텍스트 필드 내 Plceholder 생성
    private var inputTextFieldPlaceholder: some View {
        ZStack(alignment: alignment) {
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .font(.sandol(type: .regular, size: fontSize))
                    .frame(width: maxWidth, height: maxHeight, alignment: alignment)
                    .foregroundStyle((Color(red: 0.92, green: 0.90, blue: 0.97).opacity(0.50)))
                    .padding(.leading, leadingHorizontalPadding)
                    .padding(.trailing, trailingHorizontalPadding)
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
                            .frame(width: 20, height: 27)
                            .foregroundStyle(Color.textPink)
                            .padding(3)
                    })
                }
            }
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight, alignment: alignment)
        .contentShape(Rectangle())
        .onTapGesture {
            isTextFocused = true
        }
    }
}

