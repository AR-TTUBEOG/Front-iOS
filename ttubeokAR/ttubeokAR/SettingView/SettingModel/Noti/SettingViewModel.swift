//
//  SettingViewModel.swift
//  ttubeokAR
//
//  Created by Subeen on 1/20/24.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var options: [NotiOption] = [
        .init(title: "푸시 알림", description: "앱에 접속하지 않아도 받을 수 있는 광고메시지를 모두 차단하거나 허용", isSelected: false),
        .init(title: "근처 가게 알림", description: "내가 근처 가게를 지나가고 있을 때 받을 수 있는 푸시알림에 대한 허용 설정", isSelected: false),
        .init(title: "내 가게 방명록 알림", description: "내가 등록한 가게나, 산책스팟에 방명록이 달렸을 때 알림에 대한 허용 설정", isSelected: false)
    ]
}
