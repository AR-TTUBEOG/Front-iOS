//
//  WheelGamePicker.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/11/24.
//

import SwiftUI

struct WheelGamePicker: View {
    
    let options = ["상품", "꽝"]
    let sendAction: (WheelGameSetting) -> Void
    
    var body: some View {
        pickerList
    }
    
    private var pickerList: some View {
        LazyVStack(spacing: 3) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    let setting = WheelGameSetting(option: option)
                    sendAction(setting)
                }, label: {
                    Text(option)
                        .frame(maxWidth: 30, alignment: .bottom)
                        .font(.sandol(type: .semiBold, size: 12))
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 2)
                })
                if option == "상품" {
                    Divider().background(Color.white)
                }
            }
        }
        .frame(maxWidth: 80, maxHeight: 80, alignment: .center)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.52, green: 0.54, blue: 0.92).opacity(0.9), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.25, green: 0.18, blue: 0.5).opacity(0.41), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
        }
    }
}

struct WheelGamePicker_Previews: PreviewProvider {
    static var previews: some View {
        WheelGamePicker(sendAction: { setting in
            switch setting {
            case .goods:
                print("Goods selected")
            case .boom:
                print("Boom selected")
            }
        })
    }
}