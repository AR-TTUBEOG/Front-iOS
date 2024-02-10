//
//  WheelGameRulesView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/10/24.
//

import SwiftUI

struct WheelGameRulesView: View {
    
    @State private var selectedOption = "옵션1"
    let options = ["옵션1", "옵션2", "옵션3"]
    
    var body: some View {
        VStack {
            Picker("옵션 선택", selection: $selectedOption) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            
            .padding(20)
            
            Text("선택된 옵션: \(selectedOption)")
        }
    }
}


#Preview {
    WheelGameRulesView()
}
