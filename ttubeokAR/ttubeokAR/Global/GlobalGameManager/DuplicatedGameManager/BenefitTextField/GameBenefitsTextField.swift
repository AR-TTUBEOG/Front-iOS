//
//  BenefitsTextField.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/7/24.
//

import SwiftUI

struct GameBenefitsTextField: View {
    
    //MARK: - Propery
    @Binding var text: String
    
    //MARK: - Body
    var body: some View {
        inputBenefitsText
    }
    
    //MARK: - BenfitesTextFieldView
    
    private var inputBenefitsText: some View {
        ZStack(alignment: .bottomTrailing) {
            CustomTextField(text: $text,
                            placeholder: "혜택 문구를 입력해주세요",
                            fontSize: 13,
                            leadingHorizontalPadding: 18,
                            trailingHorizontalPadding: 18,
                            verticalPadding: 18,
                            maxWidth: 260,
                            maxHeight: 90,
                            onSearch: {},
                            alignment: .topLeading,
                            axis: .vertical,
                            maxLength: 20,
                            lineWidth: 0.5,
                            lineColor: Color.primary03
            )
            
            Text("\(text.count) / 20")
                .frame(maxWidth: 39, maxHeight: 13, alignment: .center)
                .font(.sandol(type: .regular, size: 11))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textPink)
                .padding(.trailing, 5)
                .padding(.bottom, 10)
        }
    }
    
}
