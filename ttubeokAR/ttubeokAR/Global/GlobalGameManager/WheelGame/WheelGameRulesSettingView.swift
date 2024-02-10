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
    @State var isPopover: Bool = false
    @State var wheelGameSetting: WheelGameSetting
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color(red: 0.25, green: 0.24, blue: 0.37).ignoresSafeArea(.all)
            makeComponentWheelGame()
        }
        .onTapGesture {
            self.keyboardResponsive()
            self.isPopover = false
        }
        
    }
    
    //MARK: - WheelGameRulesView
    
    private func makeComponentWheelGame() -> some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 25) {
                selectBtnView
                inputGoodsInfo
            }
            if isPopover {
                showPickerMenu
                    
            }
        }
    }
    
    
    private var selectBtnView: some View {
        ZStack {
            Button(action: {
                isPopover.toggle()
            }, label: {
                HStack(spacing: 10) {
                    Text(pickerName())
                        .frame(maxWidth: 32, maxHeight: 20, alignment: .trailing)
                        .foregroundStyle(Color.textPink)
                        .font(.sandol(type: .regular, size: 16))
                    
                    Icon.pickerBtn.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 15, maxHeight: 19)
                }
            })
            
        }
        
    }
    
    private var inputGoodsInfo: some View {
        CustomTextField(text: $viewModel.text,
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
        .disabled(wheelGameSetting == .boom)
    }
    
    private var showPickerMenu: some View {
        HStack {
            Spacer()
                .frame(maxWidth: 40)
            
            WheelGamePicker(sendAction: { option in
                switch option {
                case .goods:
                    self.wheelGameSetting = .goods
                    isPopover = false
                case .boom:
                    self.wheelGameSetting = .boom
                    isPopover = false
                }
            })
        }
    }
    
    private func pickerName() -> String {
        switch wheelGameSetting {
        case .goods:
            return "상품"
        case .boom:
            return "꽝"
        }
    }
    
    private func textFieldPlaceholder() -> String {
        switch wheelGameSetting {
        case .goods:
            return "상품 내용을 입력하세요"
        case .boom:
            return ""
        }
    }
    
    
    private func textFieldBackground() -> Color {
        switch wheelGameSetting {
        case .goods:
            return Color(red: 0.25, green: 0.24, blue: 0.37)
        case .boom:
            return Color(red: 0.63, green: 0.62, blue: 0.95).opacity(0.3)
        }
    }
    
    
    private func textFieldLineColor() -> Color {
        switch wheelGameSetting {
        case .goods:
            return Color.primary01
        case .boom:
            return Color(red: 0.63, green: 0.62, blue: 0.95).opacity(0.3)
        }
    }
}

struct WheelGameRulesSetting_Preview: PreviewProvider {
    static var previews: some View {
        WheelGameRulesSettingView(viewModel: WheelGameViewModel(), wheelGameSetting: .goods)
    }
}