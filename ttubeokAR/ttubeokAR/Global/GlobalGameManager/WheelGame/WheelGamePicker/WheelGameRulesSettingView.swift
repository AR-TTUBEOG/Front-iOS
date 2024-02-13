//
//  WheelGameRulesView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import SwiftUI

struct WheelGameRulesSettingView: View {
    
    //MARK: - Property
    
    @ObservedObject var viewModel: WheelGameViewModel
    let index: Int
    
    //MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            makeComponentWheelGame()
            
            if viewModel.activePopoverIndex == index {
                    showPickerMenu
            }
        }
        .frame(width: 270, height: 55)
        .onTapGesture {
            self.keyboardResponsive()
        }
        
    }
    
    //MARK: - WheelGameRulesView
    
    private func makeComponentWheelGame() -> some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 25) {
                selectBtnView
                inputGoodsInfo
            }
        }
    }
    
    
    private var selectBtnView: some View {
        ZStack {
            Button(action: {
                if viewModel.activePopoverIndex == index {
                    viewModel.activePopoverIndex = nil
                } else {
                    viewModel.activePopoverIndex = index
                }
            }, label: {
                HStack(spacing: 10) {
                    Text(pickerName())
                        .frame(width: 32, height: 20, alignment: .trailing)
                        .foregroundStyle(Color.textPink)
                        .font(.sandol(type: .regular, size: 16))
                    
                    Icon.pickerBtn.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 19)
                }
            })
        }
    }
    
    private var inputGoodsInfo: some View {
        CustomTextField(text: $viewModel.texts[index],
                        placeholder: textFieldPlaceholder(),
                        fontSize: 13,
                        leadingHorizontalPadding: 10,
                        trailingHorizontalPadding: 15,
                        verticalPadding: 4,
                        maxWidth: 160,
                        maxHeight: 30,
                        onSearch: {},
                        alignment: .center,
                        maxLength: 12,
                        backgroundColor: textFieldBackground(),
                        lineColor: textFieldLineColor()
        )
        .disabled(viewModel.wheelGameSetting[index] == .boom)
    }
    
    private var showPickerMenu: some View {
        HStack {
            Spacer()
                .frame(maxWidth: 40)
            
            WheelGamePicker(sendAction: { option in
                switch option {
                case .goods:
                    viewModel.wheelGameSetting[index] = .goods
                    viewModel.activePopoverIndex = nil
                case .boom:
                    viewModel.wheelGameSetting[index] = .boom
                    viewModel.activePopoverIndex = nil
                }
            })
        }
    }
    
    private func pickerName() -> String {
        switch viewModel.wheelGameSetting[index] {
        case .goods:
            return "상품"
        case .boom:
            return "꽝"
        }
    }
    
    private func textFieldPlaceholder() -> String {
        switch viewModel.wheelGameSetting[index] {
        case .goods:
            return "상품 내용을 입력하세요"
        case .boom:
            return ""
        }
    }
    
    
    private func textFieldBackground() -> Color {
        switch viewModel.wheelGameSetting[index] {
        case .goods:
            return Color(red: 0.25, green: 0.24, blue: 0.37)
        case .boom:
            return Color(red: 0.63, green: 0.62, blue: 0.95).opacity(0.3)
        }
    }
    
    
    private func textFieldLineColor() -> Color {
        switch viewModel.wheelGameSetting[index] {
        case .goods:
            return Color.primary01
        case .boom:
            return Color(red: 0.63, green: 0.62, blue: 0.95).opacity(0.3)
        }
    }
}
