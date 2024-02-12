//
//  FinishButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/12/24.
//

import SwiftUI

struct GameSettingFinishButton<ViewModel: ObservableObject & FinishButtonProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Button(action: {
            viewModel.finishSendAPI()
        }, label: {
            Text("설정완료")
                .frame(width: 100, height: 40)
                .font(.sandol(type: .medium, size: 16))
                .foregroundStyle(Color.white)
                .background(Color(red: 0.44, green: 0.40, blue: 0.89))
                .clipShape(.rect(cornerRadius: 19))
        })
    }
}

#Preview {
    GameSettingFinishButton(viewModel: BasketBallGameViewModel())
}
